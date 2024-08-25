import aspose.cad as cad
import sys

def convert_dwg_to_image(dwg_path, image_path):
    # Load the DWG file
    drawing = cad.Image.load(dwg_path)

    # Create an instance of CadRasterizationOptions
    rasterization_options = cad.imageoptions.CadRasterizationOptions()
    rasterization_options.page_width = 1600.0  # Use floating-point numbers
    rasterization_options.page_height = 1200.0  # Use floating-point numbers
    rasterization_options.background_color = cad.Color.white

    # Set the image options
    image_options = cad.imageoptions.PngOptions()
    image_options.vector_rasterization_options = rasterization_options

    # Save the DWG as an image
    drawing.save(image_path, image_options)

if __name__ == "__main__":
    # Expecting two arguments: the path to the DWG file and the output image path
    dwg_path = sys.argv[1]
    image_path = sys.argv[2]

    convert_dwg_to_image(dwg_path, image_path)
