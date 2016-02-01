Add-Type @"
using System;
using System.Runtime.InteropServices;
using Microsoft.Win32;
namespace Wallpaper
{
   public enum Style : int
   {
       Tile, Center, Stretch, Fit, Fill, NoChange
   }
   public class Setter {
      public const int SetDesktopWallpaper = 20;
      public const int UpdateIniFile = 0x01;
      public const int SendWinIniChange = 0x02;
      [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
      private static extern int SystemParametersInfo (int uAction, int uParam, string lpvParam, int fuWinIni);
      public static void SetWallpaper ( string path, Wallpaper.Style style ) {
	  
		
		
		 
		
		 
			Console.WriteLine("    Showing ({0:s})", path); 
		
			 SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
			 RegistryKey key = Registry.CurrentUser.OpenSubKey("Control Panel\\Desktop", true);
			 switch( style )
			 {
				case Style.Stretch :
				   key.SetValue(@"WallpaperStyle", "2") ; 
				   key.SetValue(@"TileWallpaper", "0") ;
				   break;
				case Style.Center :
				   key.SetValue(@"WallpaperStyle", "1") ; 
				   key.SetValue(@"TileWallpaper", "0") ; 
				   break;
				case Style.Tile :
				   key.SetValue(@"WallpaperStyle", "1") ; 
				   key.SetValue(@"TileWallpaper", "1") ;
				   break;
				case Style.Fit :
					key.SetValue(@"WallpaperStyle", "6");
					key.SetValue(@"TileWallpaper", "0");		
				   break;
				case Style.Fill :
					key.SetValue(@"WallpaperStyle", "10");
					key.SetValue(@"TileWallpaper", "0");		
				   break;
				case Style.NoChange :
				   break;
			 }
			 key.Close();
			 
		  }
	 
   }
}
"@

[string[]] $images = @("D:\wallpapers\DSC00209.JPG", "D:\wallpapers\DSC00157.JPG", "D:\wallpapers\DSC00152.JPG", "D:\wallpapers\DSC00470.JPG", , "D:\wallpapers\DSC00505.JPG", "D:\wallpapers\DSC00508.JPG", "D:\wallpapers\DSC00522.JPG", "D:\wallpapers\DSC00523.JPG", "D:\wallpapers\DSC00667.JPG", "D:\wallpapers\DSC01228.JPG", "D:\wallpapers\DSC01230.JPG", "D:\wallpapers\DSC01456.JPG", "D:\wallpapers\IMG_2543.JPG")
[int] $i = 0;
while ($i -le $images.length) {
	if($i -lt $images.length){
		$images[$i]
		[Wallpaper.Setter]::SetWallpaper($images[$i], 4)
		Start-Sleep -m 1800000
		$i++;
	}else{
		$i = 0;
	}
}

