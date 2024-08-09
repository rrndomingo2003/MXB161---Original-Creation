% Beat Detection Function:
function onsets = detectBeats(y, Fs)
    % Perform beat detection using a simple energy-based approach
    wndwSize = round(0.02 * Fs);  % 20 ms window
    energy = movsum(y.^2, wndwSize);
    threshold = 2 * median(energy);
    pks = find(energy > threshold);
    
    % Calculate time difference between peaks
    diffPeaks = diff(pks);
    
    % Find indices of onsets based on a threshold
    thresholdRatio = 0.5;
    onsetIndices = [true, diffPeaks > thresholdRatio * median(diffPeaks)];
    
    % Ensure onsetIndices has the same length as peaks
    if length(onsetIndices) > length(pks)
        onsetIndices = onsetIndices(1:length(pks));
    end
    
    % Extract onsets from peaks using onset indices
    onsets = pks(onsetIndices);
    
    % Remove any onsets that are too close to the end of the sound data
    validIndices = onsets <= (length(y) - wndwSize);
    onsets = onsets(validIndices);
end
