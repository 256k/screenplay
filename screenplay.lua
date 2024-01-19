--          "Screenplay"                   
-- experimenting with animation 
--            by fr0nk                 
-- --------------------------------
-- K2: clear screen
-- K3: random pick a character
-- E2: control speed
-- E3: control brightness

function init() 
  params:add_number("screenToggle","screenToggle",0,1,1)
  g = grid.connect()
  gridX = g.cols
  gridY = g.rows
  myChar = 47
  charLight = 5
  framerate = 60
  clock.run(function()  -- redraw the screen 
    while true do
      clock.sleep(1/framerate)
      if params:get("screenToggle") > 0 then redraw() end
      gridredraw() -- for the grid
    end
  end)
end

function key(n,z)
  if n==1 and z==1 then
    screen.export_screenshot(os.time())
    print("screenshot taken")
  end
  
  if n==2 and z==1 then
    screen.clear()  
    screen.update()
    g:all(0)

  end
  if n==3 and z==1 then
    myChar = math.random(33, 126)
  end
  
end

function enc(n,d)
  if n==3 then charLight = util.clamp(charLight + d, 0, 15) end
  if n==2 then framerate = util.clamp(framerate + d, 1, 130) end
end


function redraw()
    screen.level(charLight)
    screen.move(math.random(0, 128), math.random(0, 64))
    screen.text(string.char(myChar))
    screen.update()
end


function gridredraw()
  if gridX > 0 and gridY > 0 then
  g:led(math.random(1,gridX), math.random(1,gridY), math.random(0,charLight))
  g:refresh()
  end
end

