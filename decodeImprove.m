function [ message ] = decodeImprove( file )
%DECODE Decode a string from the specified image
%   Pulls a binary string from an image and converts it to an array of 
%   integers, and then into a character array

    dog = imread(file);
    [n, m] = size(dog);

    binStack = java.util.Stack();
    bin_message = zeros(1, n * m);

    %pull the binary string from the image
    index = 0;
    for i = 1:8:n
        for j = 1:8:m
            for k = 1+(8*i-1):1+(8*i-1)+8
                for l = 1+(8*j-1):1+(8*j-1)+8
            index = index + 1;
            bin_message(index) = mod(dog(i, j), 2);
                end
            end
        end
    end

    %convert from binary to decimal
    [~, b] = size(bin_message);
    message_int = zeros(floor(b/7), 1);
    stop = 0;
    for i = 1:b
        % if we see the stop message, break
        if(bin_message(i) > 0) 
            stop = stop + 1;
            if(stop == 7)
                break
            end
        else
            stop = 0;
        end
        %create chunks of 7
        binStack.push(bin_message(i));
        if(binStack.size() == 7)
            stop = 0;
            char_int = 0;
            count = 0;
            %pop and turn back into decimal
            while ~binStack.isEmpty()
                char_int = char_int + binStack.pop() * 2^count;
                count = count + 1;
            end
            %store the int values
            message_int(i/7) = char_int;
        end
    end

    %store the int values in a char array
    message = char(message_int(1:fix(i/7)))';
    %message = char(message_int)';
end