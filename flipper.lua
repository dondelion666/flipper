g = grid.connect()

leds={1,0,0,0,0,0,0,0}

function init()
  params:add_number("rate","rate",1,10,1)

  clock.run(blink)
  
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

function blink()
  local flip=0
  while true do
    clock.sleep(0.5)
    
    flip=(flip+1)%2
    
    leds[1]=flip
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
