function video = load_video(filename,time,crop_height,crop_width)

    [complete_video, ~] = mmread(filename, 1:time, [], false, true);
    [height, width, ~] = size(complete_video.frames(1).cdata);
    
    video = zeros(height, width, time);
    for time_index = 1:time
        curr_frame = complete_video.frames(time_index).cdata;
        curr_frame = mean(curr_frame, 3);
        video(:,:,time_index) = curr_frame;
    end
    
    video = video(end-crop_height+1:end,end-crop_width+1:end,:);

end

