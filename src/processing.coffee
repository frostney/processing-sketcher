Sketch = (canvas, descriptor) ->
  if typeof canvas is 'function'
    descriptor = canvas
    canvas = null
    
  if canvas is null or document.getElementById canvas is null
    canvasElement = document.createElement 'canvas'
    canvasElement.id = canvas
    document.body.appendChild canvasElement
  else
    canvasElement = document.getElementById canvas
    
  processing = new Processing canvasElement, (p) -> descriptor.call p
