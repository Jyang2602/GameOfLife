clear all;
close all;
clc

tic

N = 100;
r = 100;
c = 100;
population = rand(r, c);
logicalIndexes = population > .90;
population(logicalIndexes) = 1; % alive cells
population(~logicalIndexes) = 0;% dead cells

%Time with Tick/Tock for i = 1:100

for i = 1:100
    
    imagesc(population);
    colormap(autumn(5));
    colorbar;
    
    aliveNext = false(r, c); %Set everything to dead at first
    for j = 1:(r*c)
        indexes = [j - 1, j + 1, j + c, j + c + 1, j + c - 1, j - c, j - c + 1 ,j - c - 1];
        %Neighbor cells above using linear indexing
        indexes = indexes(indexes > 0 & indexes < (r * c) ); %Ensure no out of bounds
        if(population(j) == 1) %Cases for an alive cell
            sumAlive = sum(sum(population(indexes)));
            if (sumAlive == 2 || sumAlive == 3)
                aliveNext(j) = true; %The current cell is alive if it only has 2-3 neighbors
            end
        else %Dead cell case
            sumDead = sum(sum(population(indexes))); 
            %disp(sumDead);
            if(sumDead == 3) %If a dead cell has 3 alive neighbors
                aliveNext(j) = true;
                %disp("here")
            end
        end
    end
    population = zeros(r,c);
    population(aliveNext) = 1;
    %pause(.1);
    
    
    drawnow;
end

toc


%su = [N 1:N-1];

%Elapsed time is 1.474386 seconds.

%Also, try to implement start/stop button for user interface


