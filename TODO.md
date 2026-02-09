- Handle of drop file adding to artboard - depending on position of mouse cursor
  - sidebar drop, only goes in list. artboard drop - adds to artboard immidiately
  [x] Handle dragging images from list to artboard
- Artboard framing and sizing
- Grid Size setting UI and state propigation
 
- Draw boarder on artboard when dragging
- Handle clicking images on the artboard
  - Highlight on selected image item in the list
  - Add a search bar to filter items in the list
- Add background image file drop handler - add rendering on artboard
- 
 
- Add filter effects
  -  per image filter settings
  - Needs UI
- Add scaling and cropping tools?
  - These will be per image tile, so they should be none destructive and just a part of the object preperties.
  - we'll need to consider how to go about it, I suppose its just a Rect2i on the original image and a scaling operation. But it needs UI. Proply model operation for each is simplest, we can just have a cropping tool that allows you to select a rect on the image and then we store that as part of the image tile data. For scaling we can have a simple slider that allows you to scale the image up or down, and we store that as well. The rendering function will then take into account the cropping and scaling when drawing the image on the artboard.
- Per image grid dimension
- Handle Scaling and cropping of images on artboard

- Serialising of the board into a JSON list of the ImageTile Objects
- Deserialsition of JSON file as well.

- Improve the Image Tile Data Model to allow for missing image file, with place holder. This means we should store the original file dimensions and think about handling an edge case wher

- Exporting rendered image to file
- Add undo/redo functionality
