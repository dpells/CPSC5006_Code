function [  ] = encode( infile, message, outfile )
%ENCODE Encode a string into the specified image
%   Convert the string into a binary representation and encode it into the
%   image by comparing the binary string to the value of each pixel mod 2. 
%   If the values differ, the pixel is modified by 1 to match the value of
%   the binary string.
%
%   No return, but produces a PNG output

    %read image into matrix
    image = imread(infile);
    [n, m] = size(image);

    %convert matrix to double precision for matrix operations
    %dog = double(dog);

    %tweet = 'The Roomba vacuum cleaner just beat me to a piece of popcorn I dropped on the floor & this is how the war against the machines begins.                                                                                                        .';
    message_len = length(message); %length of string
    
    if(message_len*7 > n*m)
        error('The message is too long for the image.')
        %return
    end
    
    message_int = zeros(message_len, 1); %create an empty array to copy integers
    %copy the reduced value of each character
    for i = 1:message_len
       %tweet_int(i) = tweet(i) - 32;
       message_int(i) = uint8(message(i));
    end

    binStack = java.util.Stack(); %Look! Java stacks!! ?

    %convert each character (int) to binary and store in the stack
    for i = message_len : -1 : 1
        message_int_tmp = message_int(i);
        %while the value is greater than 0,
        %push reverse binary to stack
        %count = 0;
        if(message_int_tmp < 1)
            count = 7;
        elseif(message_int_tmp < 2)
            count = 6;
        elseif(message_int_tmp < 4)
            count = 5;
        elseif(message_int_tmp < 8)
            count = 4;
        elseif(message_int_tmp < 16)
            count = 3;
        elseif(message_int_tmp < 32)
            count = 2;
        elseif(message_int_tmp < 64)
            count = 1;
        else
            count = 0;
        end

       while message_int_tmp > 0
            rem = mod(message_int_tmp, 2);
            binStack.push(rem);
            message_int_tmp = floor(message_int_tmp / 2);
            %count = count + 1;
       end
       for j = 1 : count
            binStack.push(0);
        end
    end

    %store binary tweet in new vector
    bin_message = zeros(binStack.size(), 1);
    index = 1;
    while ~binStack.isEmpty()
        bin_message(index) = binStack.pop();
        index = index + 1;
    end

    [b, ~] = size(bin_message);
    index = 0;
    count = 0;
    for i = 1:n
        for j = 1:m
            %make sure we don't go past the message
            index = index + 1;
            if(index <= b)
                % if the mod of the pixel doesn't match the bit
                if(mod( image(i, j), 2) ~= bin_message(index))
                    % change the pixel
                    % if the pixel is already 0 we can't subtract
                    if(image(i, j) == 0)
                        image(i, j) = image(i, j) + 1;
                    else
                        image(i, j) = image(i, j) - 1;
                    end %0 check
                end %match check
            %add noise to the rest of the image
            else
                % set a stop
                if(count < 7)
                    count = count + 1;
                    if(mod( image(i, j), 2) ~= 1)
                        % change the pixel
                        % if the pixel is already 0 we can't subtract
                        if(image(i, j) == 0)
                            image(i, j) = image(i, j) + 1;
                        else
                            image(i, j) = image(i, j) - 1;
                        end %0 check
                    end %match check
                else
                    r = randi([0, 1], 1, 1);
                    if(r == 1)
                        if(image(i, j) == 0)
                            image(i, j) = image(i, j) + 1;
                        else
                            image(i, j) = image(i, j) - 1;
                        end
                    end %random noise
                end %stop
            end %message check
        end %inner loop
    end %outer loop
    
    imwrite(image, strcat(outfile,'.png'));
end