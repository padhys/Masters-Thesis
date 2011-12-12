function ConvertTraces(Dlist,station,rfile,zfile,datadir)

% FUNCTION CONVERTTRACES(DLIST,STATION)
% Converts from sac to Matlab format, rotates coords, collects headers.
% Uses function readsac.m to convert from sac to matlab formats, stores
% header information of each trace. Rotates coordinates from r and z to p
% and s using the function freetran.m
% DLIST is the list of directories to be processed. These should contain
% the sac files and not other directories holding the sac files, ie it is
% not recursive.
% STATION is the name of the station being processed, this is used in the
% saving of the .mat file holding the processed data (3 variables ptrace 
% strace and header).
% RFILE is the sac radial component file name
% ZFILE is the sac vertical component file name
% Both of these should have been previously standardized

pslows = zeros(length(Dlist),1);

for ii = 1:length(Dlist)
    % Get Header Info from sacfiles
    S1  = readsac(fullfile(Dlist(ii,:),rfile));
    S2  = readsac(fullfile(Dlist(ii,:),zfile));
    header{ii,1} = S1;
    % Get time and signal info from sacfiles
    [rtime,rcomp] = readsac(fullfile(Dlist(ii,:),rfile));
    [ztime,zcomp] = readsac(fullfile(Dlist(ii,:),zfile));
    % Convert Each trace (rotate coordinates)
    [p,s] = freetran(rcomp',zcomp',header{ii,1}.USER0,6.06,3.5,1);
    % Lump files in with time axis
    ptrace{ii}(:,1:2) = [rtime,p'];
    strace{ii}(:,1:2) = [ztime,s'];
    pslows(ii)        = header{ii,1}.USER0;
end

save([datadir,'/',station,'.mat'],'ptrace','strace','header','pslows')