%keep using direct and inverse Observation to find all the marks in view
%Mark row[x,y] -> y row[x,y] -> Z row[x,y]
function Z = observeAll(x,S,Mark)
    Y = zeros(size(Mark));
    
    for i = 1:size(Mark,1)
         Y(i,:) = directObservation(x,S,Mark(i,:));
    end
    
    detectedY = Y(~any(isnan(Y),2),:);
    Z = zeros(size(detectedY));
    
    for i = 1:size(detectedY,1)
         Z(i,:) = inverseObservation(x,S,detectedY(i,:));
    end
end