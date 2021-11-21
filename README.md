# LearningCars
## Cars learn to drive a track using a neural network along with a genetic algorithm

I wanted to write a program where cars learn on their own to drive a racetrack without crashing into the walls. 

The first step is to make a car that can drive on its own. I decided to give each car two sensors, one at each of its front corners. The sensors extend out at 45 degrees and can detect how far the car is from the edge of the track (they are shown as red lines in the photos below). Each car will also have two "weights" that together determine how it responds to the input from the sensors. Once the car is placed onto the racetrack, it will steer based on the input from the sensors and its weights. And with that, we have a driving car. All that's left now is the actual learning.

The idea I came up with to get the cars to learn to drive the track without crashing is pretty simple. First, I'll start with 10 cars with random weights. These cars will likely just crash right away. Once a car crashes into the edge of the track, it stops moving entirely, but I'll keep track of how long it drove for before crashing. This will serve as a measure of progress for how successful that car was at completing the track. Once all 10 cars have crashed, I'll use the weights from the 3 cars that survived the longest to create a new generation of 10 cars. I'll repeat this process over and over, until all of the cars can complete the track without crashing at all. Then, as a test, I'll introduce the cars to a new track and see how they do.

Generation 1: A variety of progress through the track. Peach colour cars have crashed, violet colour cars are still driving. The starting tile is green and the end tile is red.

![Image of Gen1](https://github.com/chacook/LearningCars/blob/master/img/gen1.png)


Generation 2: Improved learning and increased convergence between members of the same generation. Note the nearly stacked cars.

![Image of Gen2](https://github.com/chacook/LearningCars/blob/master/img/gen2.png)


Generation 3: Even more convergence and all 10 cars in the generation completed the track.

![Image of Gen3](https://github.com/chacook/LearningCars/blob/master/img/gen3.png)


Generation 6: The cars were given a track no previous generation had seen before.

![Image of Gen6](https://github.com/chacook/LearningCars/blob/master/img/gen6.png)


And all 10 cars completed the new track.

![Image of Gen6](https://github.com/chacook/LearningCars/blob/master/img/gen6-completed.png)


Generation 7: The cars were given a 1/2 second delay between starting times.

![Image of Gen7](https://github.com/chacook/LearningCars/blob/master/img/gen7-new.png)
