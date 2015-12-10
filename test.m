folder = 'test-images/';
files = dir([folder '*.jpg']);
for file = files'
    disp( [ 'Testing program on image ' file.name]);
    main([ folder file.name ]);
    disp('Please press enter to proceed to the next image.')
    pause
    % Remember to press Enter to proceed to the next image.
end