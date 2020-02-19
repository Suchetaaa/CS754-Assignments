function theta = soft(y, lambda)
    output = (y - lambda) .* (y >= lambda);
    output = output + (y + lambda) .* (y <= -lambda);
    theta = output;
end