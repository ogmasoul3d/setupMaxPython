param (
    [string]$Text = "Default Text"  # Default text in case no input is provided
)

# Define the bitmap dimensions
$width = 859
$height = 501

# Define the output path for the image
$outputPath = "$PSScriptRoot\Splash.png"

# Add the necessary .NET assembly for System.Drawing
Add-Type -AssemblyName System.Drawing

# Create a new bitmap
$bitmap = New-Object System.Drawing.Bitmap $width, $height

# Create a graphics object from the bitmap
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)

# Set the background color to black
$graphics.Clear([System.Drawing.Color]::Black)

# Define the font style and size
$font = New-Object System.Drawing.Font("Arial", 24, [System.Drawing.FontStyle]::Bold)

# Define the text color as white
$brush = [System.Drawing.Brushes]::White

# Define the location to draw the text (centered)
$format = New-Object System.Drawing.StringFormat
$format.Alignment = [System.Drawing.StringAlignment]::Center
$format.LineAlignment = [System.Drawing.StringAlignment]::Center

# Draw the text on the bitmap
$graphics.DrawString($Text, $font, $brush, $width / 2, $height / 2, $format)

# Save the bitmap as a .bmp file
$bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Bmp)

# Dispose of the graphics object and bitmap to free resources
$graphics.Dispose()
$bitmap.Dispose()

Write-Output "Bitmap image created at $outputPath with text: $Text"
