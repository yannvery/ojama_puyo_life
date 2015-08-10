Ojama Puyo Life
==========================================

[<img src="http://i.imgur.com/XksBAUB.jpg">](http://i.imgur.com/XksBAUB.jpg)

For a description of an ojama puyo you can check this link : [Puyo Puyo on Wikipedia](https://en.wikipedia.org/wiki/Puyo_Puyo#Ojama_.28garbage.29)

Ojama Puyo Life is an implementation of [Conway's 'game of life'](http://en.wikipedia.org/wiki/Conway's_Game_of_Life) built with ruby and [Gosu](https://www.libgosu.org/)

Installation
--------

Ojama Puyo Life has been built with `ruby 2.2.2`, be aware to use this ruby version on your locale machine.  
Install `bundler` gem if it's missing with `gem install bundler` command.  
Then run `bundle install` that will install `gosu`, `rspec` and `simplecov` gems.

How to Run
----------

In a terminal: `ruby ojama_puyo_life.rb`  
Hit `r` to generate randoms puyos  
Hit `space` to run the game

Help
----------
After launch Ojama Puyo Life you're able to :
* pause the game with `Esc`
* toggle help screen with `h`
* create or remove a puyo with left or right mouse buttons (even in pause mode)
* generate random cells with `r`
* resume the game with `space`

Resources
----------
Ojama Puyo Life was inspired by [a Ryan Bigg screencast](http://ryanbigg.com/2011/10/screencast-pilot/)  
Ojama Puyo sprite was extracted from [puyo puyo msx2](http://www.spriters-resource.com/other_systems/puyopuyomsx2/sheet/60495/)