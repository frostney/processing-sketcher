new Sketch ->
  
  # Override draw function, by default it will be called 60 times per second
  @draw = =>
    centerX = @width / 2
    centerY = @height / 2
    
    maxArmLength = Math.min centerX, centerY

    drawArm = (position, lengthScale, weight) =>
      @strokeWeight weight
      @line centerX, centerY,
        centerX + Math.sin(position * 2 * Math.PI) * lengthScale * maxArmLength,
        centerY - Math.cos(position * 2 * Math.PI) * lengthScale * maxArmLength
    
    # erase background
    @background 224
    
    now = Date.now()
    
    # Moving hours arm by small increments
    hoursPosition = (now.getHours() % 12 + now.getMinutes() / 60) / 12
    drawArm hoursPosition, 0.5, 5

    # Moving minutes arm by small increments
    minutesPosition = (now.getMinutes() + now.getSeconds() / 60) / 60
    drawArm minutesPosition, 0.80, 3

    # Moving hour arm by second increments
    secondsPosition = now.getSeconds() / 60
    drawArm secondsPosition, 0.90, 1