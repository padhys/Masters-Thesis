function SortEventDirs(workingdir,savelist,view)

% FUNCTION SORTEVENTDIRS(workingdir,savelist,view)
% A crude directory filter, to ensure we process proper event dirs.
% This discards non-numeric directory names, as well as maintaining
% constant size of directories (it adds them in an array, and if size
% changes matlab will error).
% WORKINGDIR is the working directory to look for event directories
% SAVELIST is the name to save the list of good directories, .mat format
% VIEW turn on/off print to screen of good bad dirs added/avoided.
% [true/false] [0/1]

EventList = 'Dlist.mat';

DIRitems = dir(workingdir);
Dlist = char();

for ii = 1:length(DIRitems)
    d = DIRitems(ii).name;
    if ~isnan(str2double(d))
        Dlist(end+1,:) = fullfile(workingdir,d); 
        if view == 1
            fprintf('added %s \n',d)
        end
    else
        if view == 1
            fprintf('skipped %s \n',d)
        end
    end
end

save(['Data/',savelist],'Dlist')