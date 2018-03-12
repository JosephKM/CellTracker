function runSegmentMembrane( direc,pos,chan,paramfile,outfile )
%runSegmentMembrane Is used to just get the mean of membranes from a
%dataset when you don't care about the nucleus. It expects a mask from
%ilastik that IDs nuclei and membrane pixels.
%   Detailed explanation goes here



global userParam;

try
    eval(paramfile);
catch
    error('Could not evaluate paramfile command');
end

ff=readAndorDirectory(direc);

if length(chan) < 2
    nImages = 1;
else
    nImages=length(chan)-1;
end

if isempty(ff.t)
    ntimefiles = 1;
else
    ntimefiles = length(ff.t);
end

nimg = 1;
%main loop over frames
for ii=1:ntimefiles
    
    
    filename = getAndorFileName(ff,pos,ii-1,[],[]);
    reader = bfGetReader(filename);
    
    nT = reader.getSizeT;
    
    h5file = geth5name(filename);
    
    if exist(h5file,'file')
        usemask = 1;
        [masks memMasks] = readIlastikFileNucMem(h5file);
        if isfield(userParam,'maskDiskSize')
        masks = imopen(masks,strel('disk',userParam.maskDiskSize));
        end
    else
        usemask = 0;
    end
    
    for jj = 1:nT
        
        nuc = bfMaxIntensity(reader,jj,chan(1));
        
        
        if length(chan) == 1
            fimg = nuc;
        else
        
        for xx=2:length(chan)
            fimg(:,:,xx-1) = bfMaxIntensity(reader,jj,chan(xx));
        end
        end
        
        disp(['frame ' int2str(nimg)]);
        % setup string to hold all the error messages for this frame number
        userParam.errorStr = sprintf('frame= %d\n', nimg);
        

        
        %record some info about image file.
        imgfiles(nimg).filestruct=ff;
        imgfiles(nimg).pos = pos;
        imgfiles(nimg).w = chan;
        
        
        %pre process image
        [nuc2, fimg2] =preprocessImages(nuc,fimg);
        
        
        
        %run routines to segment cells, do stats, and get the output matrix
        try
            if usemask
                if max(max(masks(:,:,jj))) == 0
                    disp('Empty mask. Continuing...');
                    peaks{nimg}=[];
                    statsArray{nimg}=[];
                    nimg = nimg + 1;

                    continue;
                end
                disp(['Using ilastik mask frame ' int2str(jj)]);
                
                
                mem = segmentMembrane(fimg2, memMasks(:,:,jj)); 
                
            else
                disp(['Segmenting frame ' int2str(jj)]);
                
            end
        catch err
            disp(['Error with image ' int2str(ii) ' continuing...']);
            
           
            membrane{nimg} = [];
           
                    nimg = nimg + 1;

            %rethrow(err);
            continue;
        end
        
        % copy over error string, NOTE different naming conventions in structs userParam
        % vs imgfiles.
        imgfiles(nimg).errorstr = userParam.errorStr;
        if userParam.verboseSegmentCells
            display(userParam.errorStr);
        end
        % compress and save the binary mask for nuclei
        
        membrane(nimg) = mem;
        
        %This prevents the resulting mat files from becoming too large.
        
        nimg = nimg + 1;
        
    end
end

dateSegmentCells = clock;
save(outfile,'imgfiles','userParam','dateSegmentCells','membrane');
end

