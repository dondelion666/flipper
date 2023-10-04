g = grid.connect()

leds={0,0,0,0,0,0,0,0}
running={0,0,0,0,0,0,0,0}

clocks={}

function init()
  
  for i=1,8 do
    clocks[i]=clock.run(blink,i,999999) --prevent error from clock.cancel
    
    params:add_number("rate"..i,"rate "..i,1,10,1)
   --[[ params:set_action("rate"..i,
      function(x) 
        clock.cancel(clocks[i])
        clocks[i]=clock.run(blink,i,x) 
      end)]]--
  end
  
  params:bang()
  
  clock.run(grid_redraw_clock)
  
end



function blink(led,rate)
  local flip=0
  while true do
    clock.sleep(rate)
    
    flip=(flip+1)%2
    
    leds[led]=flip
    grid_dirty=true
    
  end
end

--GRID

g.key = function(x,y,z)
  if y==1 and z==1 then
    if running[x]==0 then
      running[x]=1
      clocks[x]=clock.run(blink,x,params:get("rate"..x))
    elseif running[x]==1 then
      running[x]=0
      clock.cancel(clocks[x])
    end
  end
  
  grid_dirty=true
end
    

function grid_redraw_clock()
  while true do
    if grid_dirty then
      grid_redraw()
      grid_dirty = false
    end
    clock.sleep(1/50)
  end
end

function grid_redraw()
  g:all(0)
  
  for i=1,8 do
    g:led(i,1,leds[i]*running[i]*15)
  end
  
  g:refresh()
end
