parentDir = fileparts(fileparts(mfilename('fullpath')));
packageFolder = 'mopi';
% mkdir(parentDir, packageFolder);
movefile('*.m', packageFolder);
copyfile('*.sh', packageFolder);
copyfile('*.pl', packageFolder);
newPath = genpath(fullfile(parentDir, packageFolder));
addpath(newPath);

testResults = moxunit_runtests('tests', '-recursive', '-verbose',...
    '-junit_xml_file', 'testresults.xml', '-with_coverage', '-cover',...
    packageFolder, '-cover_xml_file', 'coverage.xml',...
    '-cover_json_file', 'coveralls.json');

rmpath(newPath);
movefile([packageFolder '/*.m'], parentDir);
rmdir(packageFolder, 's');