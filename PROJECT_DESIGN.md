# Project Design: Image Atlas Tool

## 1. Introduction

This document outlines the design and implementation of a Godot-based GUI application for creating texture atlases. The tool allows users to arrange a collection of images on a grid, with features for snapping, scaling, and cropping. The primary goal is to provide a simple and efficient way to create texture palettes for game development and other graphical applications.

## 2. Core Concepts

The application is built around three core concepts:

*   **The Artboard:** A 2D canvas where users can arrange their images. It provides a visual representation of the final texture atlas and supports features like a visible grid, snapping, and drag-and-drop.
*   **The Image Pool:** A sidebar that displays all the images loaded into the application. Users can drag images from the pool onto the artboard.
*   **The Image Tile:** A custom resource that represents a single image in the atlas. It stores information about the image, such as its file path, position on the artboard, scale, and crop information.

## 3. Data Model

The `ImageTile` resource is the central data structure in the application. It is defined in the `image_tile_res.gd` script and has the following properties:

*   `file_name` (String): The path to the image file.
*   `position` (Vector2i): The position of the image on the artboard.
*   `scale` (Vector2): The scale of the image.
*   `crop` (Rect2i): The crop rectangle for the image.
*   `texture` (Texture2D): The image's texture, loaded from the file.
*   `image` (Image): The raw image data.
*   `uid` (int): A unique identifier for the image tile.

## 4. Features

This section provides a detailed breakdown of the features, organized by priority.

### Priority 1: Core Functionality

| ID | Feature | Description | Status |
| -- | --- | --- | --- |
| 1 | Snapping to the grid | When an image is dropped or moved on the artboard, it should snap to the grid. | Done |
| 2 | Image Pool | The image pool should display the images that have been loaded into the application. It should be possible to drag images from the pool to the artboard. | Done |
| 3 | Exporting the artboard | It should be possible to export the artboard as a single image. | To Do |
| 4 | File Drop Handling | Dropping files on the sidebar adds them to the list. Dropping files on the artboard adds them directly to the artboard. | To Do |

### Priority 2: Usability Improvements

| ID | Feature | Description | Status |
| -- | --- | --- | --- |
| 5 | Zoom and pan controls | It should be possible to zoom and pan the artboard to make it easier to work with large images. | To Do |
| 6 | Saving and loading | It should be possible to save and load the state of the artboard, including the images and their positions, into a JSON file. | To Do |
| 7 | Resizing the grid | It should be possible to resize the grid at any time. The `SpinBox`es in the UI should be connected to the `grid_size` property of the `artboard.gd` script. | To Do |
| 8 | Reordering the image pool | It should be possible to reorder the images in the image pool by dragging and dropping them. | To Do |
| 9 | Artboard border on drag | A border should be drawn on the artboard when an image is being dragged over it. | To Do |
| 10 | Image selection | Clicking an image on the artboard should highlight it in the image pool. | To Do |
| 11 | Image search | A search bar should be added to filter the images in the image pool. | To Do |

### Priority 3: Advanced Features

| ID | Feature | Description | Status |
| -- | --- | --- | --- |
| 12 | Background image | It should be possible to set a background image for the artboard. This would be useful for tracing or for creating a parallax effect. | To Do |
| 13 | Filter effects | It should be possible to apply filter effects to the images on the artboard. | To Do |
| 14 | Scaling and cropping tools | It should be possible to scale and crop images directly on the artboard. This would involve creating a UI for the scaling and cropping tools. | To Do |
| 15 | Per-image grid dimension | Allow each image to have its own grid dimensions, overriding the global grid size. | To Do |
| 16 | Undo/Redo | Implement undo/redo functionality for all actions on the artboard. | To Do |
| 17 | Placeholder for missing images | If an image file is missing, a placeholder should be displayed on the artboard. The original file dimensions should be stored to maintain the layout. | To Do |

## 5. UI/UX

The main UI is defined in the `ui_main.tscn` scene. It consists of:

*   A **MenuBar** at the top with "File" and "Sample" menus.
*   A **SidePanel** on the left with two foldable containers:
    *   **GlobalConfig:** Contains controls for setting the grid width and height.
    *   **ImagePool:** Contains the `ItemList` of loaded images.
*   An **Artboard** on the right that displays the images.
*   A **StatusBar** at the bottom to display information.

## 6. Technical Implementation

The application is implemented using GDScript. The main scripts are:

*   `artboard.gd`: Controls the artboard, including drawing the grid, handling drag-and-drop, and managing the image tiles.
*   `image_loader.gd`: Handles loading images from the file system.
*   `image_pool.gd`: Manages the image pool `ItemList`.
*   `image_tile_res.gd`: Defines the `ImageTile` custom resource.

The main scenes are:

*   `ui_main.tscn`: The main scene of the application.
*   `artboard.tscn`: The scene for the artboard.



## 7. Future Work

*   **Theming:** Improve the visual theme of the application.
*   **Performance:** Optimize the performance for a large number of images.
*   **Extensibility:** Add support for plugins and custom tools.
*   **Testing:** Add a comprehensive test suite.

## 8. Architecture and Design Considerations

This section discusses the architectural choices and design patterns that will be used to guide the development of the application.

### 8.1. Managing Modality

As the application grows in complexity, it will be important to have a clear and robust way to manage the different actions that can be performed on the artboard. A tool-based approach will be used to manage the modality of the application.

A toolbar will be added to the UI with a set of tools (e.g., "select", "pan", "zoom"). When a tool is active, it will be responsible for handling the input events on the artboard. This will prevent conflicts between different actions and will make the application more predictable and easier to use.

For example, when the "pan tool" is active, dragging the mouse on the artboard will pan the view. When the "select tool" is active, clicking on an image will select it, and dragging it will move it.

### 8.2. Artboard Coordinates and Rendering

The artboard will be treated as an infinite integer Cartesian plane. This will allow for a flexible and scalable workspace.

Pan and zoom will be implemented by applying a transform to the artboard's canvas. This will allow the user to navigate the artboard and to work with images of different sizes. The grid will also be drawn with the transform applied, so it will scale and pan with the artboard.

For exporting the artboard, the application will find the bounding rectangle of all the visible entities and then render that portion of the artboard to an image.

### 8.3. Entity Representation

The image tiles are currently drawn directly on the artboard using the `_draw` function. This is a good approach for performance, as it avoids the overhead of creating and managing a large number of nodes.

However, as the application grows in complexity, it may be beneficial to switch to a node-based approach. Using nodes for the image tiles would make it easier to handle input events, to manage the z-index of the images, and to add custom behavior to the images.

For now, the application will continue to use direct drawing. This decision will be revisited if the complexity of the application increases to a point where the benefits of using nodes outweigh the performance costs.

**Pros and Cons of using Nodes vs. Direct Drawing:**

| Approach | Pros | Cons |
| --- | --- | --- |
| **Nodes** | - Easier to handle input events<br>- Built-in properties for position, scale, and rotation<br>- Can have their own scripts | - Slower for a large number of entities<br>- Requires managing the scene tree<br>- Can lead to synchronization issues between the data model and the nodes |
| **Direct Drawing** | - Faster for a large number of entities<br>- More control over the rendering<br>- A single source of truth for the data | - More complex to handle input events<br>- Requires manual implementation of transformations<br>- Can be harder to debug |
