filename = 'data.bin';

fid = fopen(filename, 'r');
if fid == -1
    error('Cannot open file: %s', filename);
end

imageBits = false(8192, 64);  % Each line should be 64 bits

for row = 1:8192
    line = fgetl(fid);
    if ~ischar(line) || length(line) ~= 64
        error('Line %d is invalid or corrupt.', row);
    end
    imageBits(row, :) = line == '1';
end

fclose(fid);

% Total bits: 8192 × 64 = 524,288 bits → reshape to 512 × 1024
bitArray = reshape(imageBits.', 1024, 512)';
imshow(bitArray);
title('Binary Image from ASCII Data (768 x 1024)');
