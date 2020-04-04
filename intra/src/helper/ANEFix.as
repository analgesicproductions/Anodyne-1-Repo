package helper 
{
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExtensionContext;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author Melos Han-Tani
	 */
	public class ANEFix 
	{
		private static var 
			callback_error:Function = null, 
			callback_ioerror:Function = null, 
			callback_output:Function = null;

	/** @param extensionID:String id of the ane extension to fix
	  * @param onExit:Function callback function with first arguments the value of extensionID and for the second the boolean state of the fix operation
	  **/
	public static  function fixANE(extensionID:String, onExit:Function = null,is_steam:Boolean = false):Boolean {
	
			if (!NativeProcess.isSupported) {
				if (onExit != null) {
					trace("Nope! 30");
					onExit(extensionID, false);
				}
				trace("Nope! 33");
				return false;
			}
			// init event listners 
			if (callback_output==null)
				callback_output = 
					function(event:ProgressEvent):void {
						var process:NativeProcess = event.target as NativeProcess;
						trace("OUT -", process.standardOutput.readUTFBytes(process.standardError.bytesAvailable)); 
					};
			if (callback_error==null)
				callback_error = 
					function(event:ProgressEvent):void {
						var process:NativeProcess = event.target as NativeProcess;
						trace("ERROR -", process.standardError.readUTFBytes(process.standardError.bytesAvailable)); 
					};
			if (callback_ioerror==null)
				callback_ioerror = 
					function(event:IOErrorEvent):void {
						trace(event.toString());
					};

			var ext_dir:File;
			try {
				ext_dir = ExtensionContext.getExtensionDirectory(extensionID);
			} catch (e:*) {
				if (onExit != null) {
					trace("Nope! 59");
					onExit(extensionID, false);
				}
				trace("Nope! 63");
				return false;
			}
			if (!ext_dir.isDirectory) {
				if (onExit != null) {
					trace("Nope! 64");
					onExit(extensionID, false);
				}
				trace("Nope! 71");
				return false;
			}
			
			var ane_dir:File = ext_dir.resolvePath("META-INF/ANE/");
			var ext_stream:FileStream = new FileStream();
			ext_stream.open(ane_dir.resolvePath("extension.xml"), FileMode.READ);
			var ext_xml:XML = XML(ext_stream.readUTFBytes(ext_stream.bytesAvailable));
			ext_stream.close();

			var defaultNS:Namespace = ext_xml.namespace("");
			var framework:String = ext_xml.defaultNS::platforms.defaultNS::platform.(@name=="MacOS-x86").defaultNS::applicationDeployment.defaultNS::nativeLibrary.text();
			if (!framework) {
				if (onExit != null) {
					trace("Nope! 80");
					onExit(extensionID, false);
				}
				trace("Nope! 85");
				return false;
			}

			var framework_dir:File = ane_dir.resolvePath('MacOS-x86/'+framework);
			// list of symlink files
			var symlink:Vector.<String> = new Vector.<String>(3, true);
			symlink[0] = 'Resources';
			symlink[1] = framework_dir.name.substr(0, framework_dir.name.length-framework_dir.extension.length-1);
			symlink[2] = 'Versions/Current';
			var fileToFix:int = symlink.length,
				fileFixed:int = 0,
				fileFailed:int = 0;
			symlink.every(
				function(item:String, index:int, a:Vector.<String>):Boolean {
					var f:File = framework_dir.resolvePath(item);
					if (!f.isSymbolicLink) {
						var fs:FileStream = new FileStream();
						fs.open(f, FileMode.READ);
						var lnk:String = fs.readUTFBytes(fs.bytesAvailable);
						fs.close();       
						var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
						nativeProcessStartupInfo.executable = new File('/bin/ln');
						nativeProcessStartupInfo.workingDirectory = f.parent;
						nativeProcessStartupInfo.arguments = new Vector.<String>(3, true);
						nativeProcessStartupInfo.arguments[0] = "-Fs";
						nativeProcessStartupInfo.arguments[1] = lnk;
						nativeProcessStartupInfo.arguments[2] = f.name;


						var process:NativeProcess = new NativeProcess();    
						process.start(nativeProcessStartupInfo);
						//process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, callback_output);
						process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, callback_error);
						process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, callback_ioerror);
						process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, callback_ioerror);
						process.addEventListener(
							NativeProcessExitEvent.EXIT, 
							function (event:NativeProcessExitEvent):void {
								if (event.exitCode==0)
									fileFixed++;
								else
									fileFailed++

								if (fileFixed+fileFailed==fileToFix) {
									if (fileFailed==0)  {
										trace('ANE '+extensionID+' fixed.');
									} else {
										trace('Unable to fix ANE ' + extensionID + '!');
									}
									if (onExit != null) {
										trace("Nope! 133");
										onExit(extensionID, fileFailed == 0);
									}
								}
							}
						);
					} else {
						trace("A file fixed.? 146");
						fileFixed++;
					}
					return true;
				}
			);
			if (fileFixed == 3) {
				if (onExit != null) {
					onExit(extensionID, true);
				}
			}
			trace("Exiting: 150");
			return true;
		}
	}
}