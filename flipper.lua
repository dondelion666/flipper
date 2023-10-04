g = grid.connect()

leds={0,0,0,0,0,0,0,0}

clocks={}

function init()
  
  for i=1,8 do
    clocks[i]=clock.run(blink,i,math.random(1,10))
  end
  
  clock.run(grid_redraw_clock)
  
end

function grid_redraw_clock()
  while true do
    if grid_dirty then
      grid_redraw()
      grid_dirty = false
    end
    clock.sleep(1/30)
  end
end

function blink(led,rate)
  local flip=0
  while true do
    clock.sleep(rate/10)
    
    flip=(flip+1)%2
    
    leds[led]=flip
    grid_dirty=true
    
  end
end

function grid_redraw()
  g:all(0)
  
  for i=1,8 do
    g:led(i,1,leds[i]*15)
  end
  
  g:refresh()
end
