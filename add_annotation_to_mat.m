function add_annotation_to_mat(DIR,annotation_file,template_file)
cd(DIR);
load(template_file);
syllables = [templates.wavs.segType];
load(annotation_file);
num_files = numel(keys);
for fnum = 1:num_files
    matfilename = [keys{fnum}(1:end-3) 'mat'];
    cd mat;
    load(matfilename);
    labels = zeros(size(t));
    for segnum = 1:numel(elements{fnum}.segFileStartTimes)
        if (elements{fnum}.segType(segnum) >= 0)
            labels((t >= elements{fnum}.segFileStartTimes(segnum)) & ...
                (t <= elements{fnum}.segFileEndTimes(segnum))) = ...
                find(syllables == elements{fnum}.segType(segnum));
        end
    end
    save(matfilename,'labels','-append');
    cd ..
end
