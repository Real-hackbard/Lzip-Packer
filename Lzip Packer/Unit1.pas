unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.Shell.ShellCtrls, WinApi.ShellAPI, System.IniFiles,
  Vcl.StdCtrls, Vcl.FileCtrl, System.StrUtils, System.IOUtils, System.Types,
  Vcl.Menus, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    StatusBar1: TStatusBar;
    OpenDialog2: TOpenDialog;
    PopupMenu1: TPopupMenu;
    Clear1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox6: TGroupBox;
    ListBox1: TListBox;
    GroupBox4: TGroupBox;
    ComboBox1: TComboBox;
    Button8: TButton;
    GroupBox5: TGroupBox;
    Label8: TLabel;
    ComboBox2: TComboBox;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    ScrollBar1: TScrollBar;
    ComboBox3: TComboBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox12: TCheckBox;
    Panel1: TPanel;
    Label7: TLabel;
    Label4: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Panel2: TPanel;
    Button1: TButton;
    Button6: TButton;
    Button7: TButton;
    Properties1: TMenuItem;
    SaveDialog1: TSaveDialog;
    Label2: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ComboBox4: TComboBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    CheckBox8: TCheckBox;
    Label19: TLabel;
    Image1: TImage;
    Folder1: TMenuItem;
    N1: TMenuItem;
    Pack1: TMenuItem;
    Unpack1: TMenuItem;
    N2: TMenuItem;
    Panel3: TMenuItem;
    N3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Properties1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label2MouseLeave(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure Label6MouseLeave(Sender: TObject);
    procedure Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label11MouseLeave(Sender: TObject);
    procedure Label11MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label12Click(Sender: TObject);
    procedure Label12MouseLeave(Sender: TObject);
    procedure Label12MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ComboBox4Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure Folder1Click(Sender: TObject);
    procedure Pack1Click(Sender: TObject);
    procedure Unpack1Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
  private
    { Private declarations }
    flbHorzScrollWidth: Integer;
    procedure FolderContent(const FolderPath: string);
  public
    { Public declarations }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form1: TForm1;
  app, path : string;  // compressors & folder files
  TIF : TIniFile;

implementation

{$R *.dfm}

// get application MainPath
function MainDir : string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var
  OPT :string;
begin
   OPT := 'Options';

   // Create the 'optins' folder if it does not exist.
   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
      WriteInteger(OPT,'Compressor',ComboBox1.ItemIndex);
      WriteInteger(OPT,'Mode',ComboBox4.ItemIndex);
      WriteInteger(OPT,'Priority',ComboBox2.ItemIndex);
      WriteBool(OPT,'Keep',CheckBox1.Checked);
      WriteBool(OPT,'Force',CheckBox2.Checked);
      WriteBool(OPT,'Verbose',CheckBox3.Checked);
      WriteBool(OPT,'Status',CheckBox4.Checked);
      WriteBool(OPT,'Console',CheckBox12.Checked);
      WriteBool(OPT,'Quiet',CheckBox5.Checked);
      WriteBool(OPT,'Trailing',CheckBox6.Checked);
      WriteBool(OPT,'Recompress',CheckBox7.Checked);
      WriteInteger(OPT,'CompressLevel', Scrollbar1.Position);
      WriteInteger(OPT,'CompressMode',ComboBox3.ItemIndex);
      WriteBool(OPT,'StayTop',CheckBox8.Checked);
      Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var
  OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
    TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
    with TIF do
    begin
      Combobox1.ItemIndex:=ReadInteger(OPT,'Compressor',ComboBox1.ItemIndex);
      Combobox4.ItemIndex:=ReadInteger(OPT,'Mode',ComboBox4.ItemIndex);
      Combobox2.ItemIndex:=ReadInteger(OPT,'Priority',ComboBox2.ItemIndex);
      CheckBox1.Checked:=ReadBool(OPT,'Keep',CheckBox1.Checked);
      CheckBox2.Checked:=ReadBool(OPT,'Force',CheckBox2.Checked);
      CheckBox3.Checked:=ReadBool(OPT,'Verbose',CheckBox3.Checked);
      CheckBox4.Checked:=ReadBool(OPT,'Status',CheckBox4.Checked);
      CheckBox12.Checked:=ReadBool(OPT,'Console',CheckBox12.Checked);
      CheckBox5.Checked:=ReadBool(OPT,'Quiet',CheckBox5.Checked);
      CheckBox6.Checked:=ReadBool(OPT,'Trailing',CheckBox6.Checked);
      CheckBox7.Checked:=ReadBool(OPT,'Recompress',CheckBox7.Checked);
      Scrollbar1.Position:=ReadInteger(OPT,'CompressLevel',Scrollbar1.Position);
      Combobox3.ItemIndex:=ReadInteger(OPT,'CompressMode',ComboBox3.ItemIndex);
      CheckBox8.Checked:=ReadBool(OPT,'StayTop',CheckBox8.Checked);
      Free;
    end;
  end;
end;

// display windows file properties dialog
procedure PropertiesDialog(const aFilename: string);
var
  sei: ShellExecuteInfo;
begin
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.lpFile := PChar(aFilename);
  sei.lpVerb := 'properties';
  sei.fMask  := SEE_MASK_INVOKEIDLIST;
  ShellExecuteEx(@sei);
end;

// Determining the size of the entire folder.
function GetDirectorySize(const Path: string): Int64;
var
  SearchRec: TSearchRec;
  FindResult: Integer;
  SearchPath: string;
begin
  Result := 0;
  SearchPath := IncludeTrailingPathDelimiter(Path);

  // Search for all files and folders
  FindResult := FindFirst(SearchPath + '*.*', faAnyFile, SearchRec);
  try
    while FindResult = 0 do
    begin
      // Ignore specific directories
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      begin
        if (SearchRec.Attr and faDirectory) <> 0 then
        begin
          // If it is a subfolder, call the function recursively.
          Inc(Result, GetDirectorySize(SearchPath + SearchRec.Name));
        end
        else
        begin
          // Add file size to the total sum
          Inc(Result, SearchRec.Size);
        end;
      end;
      FindResult := FindNext(SearchRec);
    end;
  finally
    System.SysUtils.FindClose(SearchRec);
  end;
end;

// Directly loading all files in a folder into the listbox
procedure TForm1.Folder1Click(Sender: TObject);
begin
  Button1.Click;
end;

procedure TForm1.FolderContent(const FolderPath: string);
var
  FileName: string;
begin
  ListBox1.Items.Clear;
  for FileName in TDirectory.GetFiles(FolderPath) do
  begin
    ListBox1.Items.Add(FileName); // Adds the full path

    // Or just the filename:
    // ListBox1.Items.Add(ExtractFileName(FileName));
  end;
end;

// Determining whether or not the folder name contains spaces.
function HasSpaceInFolder(const Path: string): Boolean;
var
  FolderName: string;
begin
  // removes the last slash or backslash from a folder path string if it is there
  FolderName := ExtractFileName(ExcludeTrailingPathDelimiter(Path));
  // Here, the specified string is checked—in this case, a space.
  Result := Pos(' ', FolderName) > 0;
end;

// Determine the list of files to be displayed as icons in the list box.
procedure GetAllFilesExtra(List: TStrings);
var
  Search: TSearchRec;
begin
  //Path := ExtractFilePath(ParamStr(0)); // exe main path

  // find all files in folder
  if FindFirst(Path + '*.*', faAnyFile, Search) = 0 then
  try
    repeat
      if (Search.Attr <> faDirectory) and (Search.Name[1] <> '.') then
        // add the files in the listbox
        List.Add(Path + Search.Name);
    until FindNext(Search) <> 0;
  finally
    FindClose(Search);
  end;
end;

// Convert the icon to a bitmap.
procedure IcoToBmpA(Ico: TIcon; Bmp: TBitmap; SmallIcon: Boolean);
var
  WH: Byte; // Width and Height
begin
  with Bmp do
  begin
    // Here, any color can be specified as transparent.
    Canvas.Brush.Color := clFuchsia;
    TransparentColor := clFuchsia;

    // Determine the width and height and draw as a bitmap.
    Width := 16;
    Height := 16;
    Canvas.Draw(0, 0, Ico);

    if SmallIcon then
      WH := 16
    else
      WH := 32;

    // reduce or enlarge to a specific size
    Canvas.StretchDraw(Rect(0, 0, WH, WH), Bmp);
    Width := WH; Height := WH;
    Transparent :=  True;
  end;
end;

// Here, the file's icon is retrieved from shell32.dll.
procedure GetIconFromFileB(const FileName: String; Icon: TIcon;
  SmallIcon: Boolean);
var
  sfi: TSHFILEINFO;
const
  uFlags : array[Boolean] of DWord = (SHGFI_LARGEICON, SHGFI_SMALLICON);
begin
  if SHGetFileInfo(PChar(FileName), 0, sfi, SizeOf(sfi), SHGFI_ICON or
     uFlags[SmallIcon]) <> 0 then
    Icon.Handle := sfi.hIcon;
end;

{ Draw the icons from "shell32.dll" into the list box next to the
  corresponding files. }
procedure DrawListBoxExtra(Control: TWinControl; Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
const
  { These constants declare a constant or typed array that uses the Boolean
    data type as the index (key) and returns color values of type TColor. }
  Col1: array [Boolean] of TColor = ($00F8F8F8, clWindow);
  Col2: array [Boolean] of TColor = (clInactiveCaptionText, clWindowText);
var
  Icon: TIcon;
  Bmp: TBitmap;
begin
  with (Control as TListbox) do
  begin
    // Create memory access for the icon and bitmap.
    Icon := TIcon.Create;
    Bmp := TBitmap.Create;
    try
      if odSelected in State then
        Canvas.Font.Color := clCaptionText
      else
      begin
        // determine properties
        Bmp.Canvas.Brush.Color := Canvas.Brush.Color;
        Canvas.Brush.Color := Col1[Odd(Index)];
        Canvas.Font.Color := Col2[(Control as TListBox).Enabled];
      end;
      GetIconFromFileB(Items[Index], Icon, True);
      IcoToBmpA(Icon, Bmp, True);
      // Vertical and horizontal spacing between the item strings and the bitmaps
      Canvas.TextRect(Rect, Rect.Left + Bmp.Width + 4, Rect.Top + 2, Items[Index]);
      // Draw the graphics into the list box.
      Canvas.Draw(Rect.Left, Rect.Top, Bmp);
    finally
      Bmp.Free;
      Icon.Free;
    end;
  end;
end;

// compress level setting bar
procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  Label10.Caption := 'Level  : ' + IntToStr(ScrollBar1.Position);
end;

procedure TForm1.Unpack1Click(Sender: TObject);
begin
  Button7.Click;
end;

// Start the help message process and wait until it is finished.
procedure ExecuteHelpmessageAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected process flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble help message command line
  CmdLine := Format('cmd.exe /k "%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  StartupInfo.wShowWindow := SW_NORMAL;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// Start the decompression process and wait until it is finished.
procedure ExecuteDecompressAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble command line
  CmdLine := Format('"%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  if Form1.CheckBox12.Checked = true then
  begin
    StartupInfo.wShowWindow := SW_NORMAL;
  end else begin
    StartupInfo.wShowWindow := SW_HIDE;
  end;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// Start the compression process and wait until it is finished.
procedure ExecuteAndWait(const FileName, Parameters: string);
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  CmdLine: string;          // command line
  ExitCode: Cardinal;       // Safely closing the console
  SelectedPriority: DWORD;  // priority class
  ProgramPath: string;
begin
  // Read the selected flag from the ComboBox objects.
  SelectedPriority := DWORD(Form1.ComboBox2.Items.Objects[Form1.ComboBox2.ItemIndex]);

  // Assemble command line
  CmdLine := Format('"%s" %s', [FileName, Parameters]);

  // Initialize structures
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);
  StartupInfo.dwFlags := STARTF_USESHOWWINDOW;

  // show or hide console
  if Form1.CheckBox12.Checked = true then
  begin
    StartupInfo.wShowWindow := SW_NORMAL;
  end else begin
    StartupInfo.wShowWindow := SW_HIDE;
  end;

  // Create process
  if CreateProcess(
    nil,                       // Module name (use 'nil' and command in CmdLine)
    PChar(CmdLine),            // Command line
    nil,                       // Process safety attributes
    nil,                       // Thread safety attributes
    False,                     // Handle inheritance
    SelectedPriority,          // Creation flags (starts in a new console window)
    nil,                       // New environment specification block
    nil,                       // Current Directory
    StartupInfo,               // STARTUP INFO
    ProcessInfo) then          // PROCESS INFORMATION
  begin
    // Wait until the called program has finished
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

    // Optional: Retrieve and display the process exit code.
    GetExitCodeProcess(ProcessInfo.hProcess, ExitCode);

    // Close handles to avoid memory leaks.
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end
  else
    // Throws an error if the process could not be started.
    RaiseLastOSError;
end;

// precise determination of the file size
function Get_File_Size(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  // check if file exists
  FH := FindFirstFile(PChar(S), FD);
  // check file handle ist value
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      //CloseHandle(FH);
    end;
end;

// load folder for multi compress operation
procedure TForm1.Button1Click(Sender: TObject);
begin
  if SelectDirectory('Select directory', '', path) then
  begin
    if ListBox1.Items.Count > -1 then Properties1.Enabled := true;
    ListBox1.Clear;
    Button6.Enabled := true;
    Button7.Enabled := true;
    Pack1.Enabled := true;
    Unpack1.Enabled := true;
    // Add a backslash to the path.
    path := path + '\';
    GetAllFilesExtra(ListBox1.Items);
    // Determine the size of the entire folder content.
    StatusBar1.Panels[1].Text := IntToStr( GetDirectorySize(path) div 1000) + ' kb';
    // count loaded files
    GroupBox6.Caption := ' Lz, bz2, gz - Multiple Files : ' + IntToStr(ListBox1.Items.Count) + ' ';

    // update shell icons
    ListBox1.Repaint;
    ListBox1.SetFocus;
  end;

end;

// start compress operation
procedure TForm1.Button6Click(Sender: TObject);
var
  filename : string;
  i : integer;
begin
  Screen.Cursor := crHourGlass;
  // clear parameter string
  Label3.Caption := '';

  { ----- define the parameter flags for the compressors ----- }

  // keep original files unchaned
  if CheckBox1.Checked = true then Label3.Caption := Label3.Caption + ' -k';
  // force overwrite of output file
  if CheckBox2.Checked = true then Label3.Caption := Label3.Caption + ' -f';
  // be verbose (a 2nd -v gives more)
  if CheckBox3.Checked = true then Label3.Caption := Label3.Caption + ' -v';
  // display status in percent & filesize ratio
  if CheckBox4.Checked = true then Label3.Caption := Label3.Caption + ' -vv';
  // quiet display output
  if CheckBox5.Checked = true then Label3.Caption := Label3.Caption + ' -q';
  // trailling error
  if CheckBox6.Checked = true then Label3.Caption := Label3.Caption + ' -a';
  // force re-compression of compressed files
  if CheckBox7.Checked = true then Label3.Caption := Label3.Caption + ' -F';

  // compression level setting
  case ComboBox3.ItemIndex of
    0 : begin
          // fastest possible compression process
          Label3.Caption := Label3.Caption + ' --fast';
        end;
    1 : begin
          // best possible compression process
          Label3.Caption := Label3.Caption + ' --best';
        end;
        // manual setting of the compression process
    2 : Label3.Caption := Label3.Caption + ' -' + IntToStr(ScrollBar1.Position);
  end;

  // Determine the path to "*zip.exe".
  case ComboBox1.ItemIndex of
    0 : app := ExtractFilePath(Application.ExeName)+'Data\lzip\bin\lzip.exe';
    1 : app := ExtractFilePath(Application.ExeName)+'Data\plzip\bin\plzip.exe';
    2 : app := ExtractFilePath(Application.ExeName)+'Data\plzip\bin64\plzip.exe';
    3 : app := ExtractFilePath(Application.ExeName)+'Data\bzip2\bin\bzip2.exe';
    4 : app := ExtractFilePath(Application.ExeName)+'Data\gzip\bin\gzip.exe';
  end;

  // update program
  StatusBar1.Panels[5].Text := 'wait, compressing';
  Application.ProcessMessages;

  // Start the compression folder process and wait until it is finished.
  // All kinds of files are being compressed.
  case ComboBox4.ItemIndex of
    0 : begin
          if ListBox1.ItemIndex > -1 then
          begin
            // Identify the files selected for packing operation
            with ListBox1 do
            begin
              for i := -1 + Items.Count downto 0 do
              begin
                if Selected[i] then filename := filename + '"' + ListBox1.Items.Strings[i] + '" ';
              end;
            end;

            // pack single files
            ExecuteAndWait(PChar(app), PChar(Label3.Caption + ' -a ' + filename));
          end;
        end;

        // pack entire folder
    1 : ExecuteAndWait(PChar(app), PChar(Label3.Caption + ' ' + '"' + path + '*.*"'));
  end;

  // must be emptied to see only the new files
  ListBox1.Clear;
  // load the new compressed files
  FolderContent(path);

  // Determine the size of the entire folder content.
  StatusBar1.Panels[3].Text := IntToStr( GetDirectorySize(path) div 1000) + ' kb';

  Screen.Cursor := crDefault;
  StatusBar1.Panels[5].Text := 'Folder compress finish.';
  // update shell icons
  ListBox1.Repaint;
  ListBox1.SetFocus;
end;

// start folder decompressed opration
procedure TForm1.Button7Click(Sender: TObject);
var
  filename : string;
    i : integer;
begin
  Screen.Cursor := crHourGlass;
  // clear parameter string
  Label3.Caption := '';

  // Determine the path to "*zip.exe".
  case ComboBox1.ItemIndex of
    0 : app := ExtractFilePath(Application.ExeName)+'Data\lzip\bin\lzip.exe';
    1 : app := ExtractFilePath(Application.ExeName)+'Data\plzip\bin\plzip.exe';
    2 : app := ExtractFilePath(Application.ExeName)+'Data\plzip\bin64\plzip.exe';
    3 : app := ExtractFilePath(Application.ExeName)+'Data\bzip2\bin\bzip2.exe';
    4 : app := ExtractFilePath(Application.ExeName)+'Data\gzip\bin\gzip.exe';
  end;

  // update program
  StatusBar1.Panels[5].Text := 'wait, decompressing';
  Application.ProcessMessages;

  // Start the decompression process and wait until it is finished.
  // Do not remove the "-d" parameter, as it is for decompression operation.
  case ComboBox4.ItemIndex of
    0 : begin
          if ListBox1.ItemIndex > -1 then
          begin
            // Identify the files selected for unpack operation
            with ListBox1 do
            begin
              for i := -1 + Items.Count downto 0 do
              begin
                if Selected[i] then filename := filename + '"' + ListBox1.Items.Strings[i] + '" ';
              end;
            end;

            // unpack files
            ExecuteDecompressAndWait(PChar(app), PChar(Label3.Caption + ' -vv -d ' + filename));
          end;

        end;
        // folder decompress operation
    1 : ExecuteDecompressAndWait(PChar(app), PChar(' -d ' + '"' + path + '*.*"'));
  end;

  // Determine the size of the entire folder content.
  StatusBar1.Panels[3].Text := IntToStr( GetDirectorySize(path) div 1000) + ' kb';
  // must be emptied to see only the new files
  ListBox1.Clear;
  // load the new decompressed files
  FolderContent(path);
  Screen.Cursor := crDefault;
  StatusBar1.Panels[5].Text := 'Folder decompress finish.';
  // update shell icons
  ListBox1.Repaint;
  ListBox1.SetFocus;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  // Determine the path to "*zip.exe".
  case ComboBox1.ItemIndex of
    0 : app := ExtractFilePath(Application.ExeName)+'Data\lzip\bin\lzip.exe';
    1 : app := ExtractFilePath(Application.ExeName)+'Data\plzip\bin\plzip.exe';
    2 : app := ExtractFilePath(Application.ExeName)+'Data\plzip\bin64\plzip.exe';
    3 : app := ExtractFilePath(Application.ExeName)+'Data\bzip2\bin\bzip2.exe';
    4 : app := ExtractFilePath(Application.ExeName)+'Data\gzip\bin\gzip.exe';
  end;

  // execute the help console message for selected compressor
  ExecuteHelpmessageAndWait(PChar(app), PChar(' -h '));
  StatusBar1.SetFocus;
end;

// display the help message information console
procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  Label18.Caption := 'On'
    else
  Label18.Caption := 'Off';
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked = true then CheckBox4.Checked := false;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked = true then CheckBox3.Checked := false;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  if CheckBox8.Checked = true then
  begin
    SetWindowPos(Handle, HWND_TOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end else begin
    SetWindowPos(Handle, HWND_NOTOPMOST, Left,Top, Width,Height,
             SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  end;
end;

// clear all items in the listbox
procedure TForm1.Clear1Click(Sender: TObject);
begin
  ListBox1.Clear;
  Button6.Enabled := false;
  Button7.Enabled := false;
  Pack1.Enabled := false;
    Unpack1.Enabled := false;
  GroupBox6.Caption := ' Lz, bz2, gz - Multiple Files : 0 ';
  StatusBar1.Panels[1].Text := '0 kb';
  StatusBar1.Panels[3].Text := '0 kb';
  Properties1.Enabled := false;
  ListBox1.SetFocus;
end;

// compress level settings for file size
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    1, 2, 3 :  begin
                ComboBox4.Enabled := false;
                ComboBox4.ItemIndex := 1;
               end;
  else
    ComboBox4.Enabled := true;
  end;
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
begin
  case ComboBox3.ItemIndex of
  0 : begin
        Label10.Enabled := false;       // super fast ( automatic )
        ScrollBar1.Enabled := false;
      end;
  1 : begin
        Label10.Enabled := false;       // best ration ( automatic )
        ScrollBar1.Enabled := false;
      end;
  2 : begin
        Label10.Enabled := true;        // custom setting ( manual )
        ScrollBar1.Enabled := true;
      end;
  end;
end;

// change pack -/ unpack mode, file or entire ofolder
procedure TForm1.ComboBox4Change(Sender: TObject);
begin
  case ComboBox4.ItemIndex of
    0 : Label16.Caption := ComboBox4.Text;
    1 : Label16.Caption := ComboBox4.Text;
  end;
end;

// write the options
procedure TForm1.FormActivate(Sender: TObject);
begin
  if PageControl1.ActivePage = TabSheet1 then
    ListBox1.SetFocus;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : integer;
begin
  // It is necessary in order to see the horizontal scrollbar in the listbox.
  DoubleBuffered := true;
  Listbox1.Perform(LB_SetHorizontalExtent, 2000, Longint(0));

  StatusBar1.Panels[5].Text := 'lzip.exe found!';

  { Checking for the existence of the files that generate the
    compression and decompression process.}

  // check if lzip  exists
  if not FileExists(MainDir + 'Data\lzip\bin\lzip.exe') then
  begin
    MessageDlg('Error "lzip.exe" not found, check Folder ..\Data\lzip\..' +Chr(10)+
               'Download "lzip.exe" if not found.'
               ,mtWarning, [mbOK], 0);
    Label4.Font.Color := clMaroon;
    Label4.Caption := 'The program requires lzip.exe, which was not found.';
    StatusBar1.Panels[5].Text := 'lzip.exe not found!';
  end;

  // check if plzip  exists
  if not FileExists(MainDir + 'Data\plzip\bin\plzip.exe') then
  begin
    MessageDlg('Error "plzip.exe" not found, check Folder ..\Data\plzip\..' +Chr(10)+
               'Download "plzip.exe" if not found.'
               ,mtWarning, [mbOK], 0);
    Label4.Font.Color := clMaroon;
    Label4.Caption := 'The program requires plzip.exe, which was not found.';
    StatusBar1.Panels[5].Text := 'plzip.exe not found!';
  end;

  // check if plzip 64bit  exists
  if not FileExists(MainDir + 'Data\plzip\bin64\plzip.exe') then
  begin
    MessageDlg('Error "plzip.exe" not found, check Folder ..\Data\64plzip\..' +Chr(10)+
               'Download "plzip.exe" if not found.'
               ,mtWarning, [mbOK], 0);
    Label4.Font.Color := clMaroon;
    Label4.Caption := 'The program requires plzip.exe, which was not found.';
    StatusBar1.Panels[5].Text := 'plzip.exe not found!';
  end;

  // Prevents free text input
  ComboBox2.Style := csDropDownList;
  // Link names and the corresponding WinAPI constants
  ComboBox2.AddItem('Idle (Low)', TObject(IDLE_PRIORITY_CLASS));
  // Manually defined for older Delphi versions, if applicable.
  ComboBox2.AddItem('Below Normal', TObject($00004000));
  ComboBox2.AddItem('Normal', TObject(NORMAL_PRIORITY_CLASS));
  // Manually defined if necessary
  ComboBox2.AddItem('Above Normal', TObject($00008000));
  ComboBox2.AddItem('High (Process)', TObject(HIGH_PRIORITY_CLASS));
  ComboBox2.AddItem('Realtime (Real-Time)', TObject(REALTIME_PRIORITY_CLASS));
  // Select 'Normal' by default (index 4)
  ComboBox2.ItemIndex := 4;

  Application.HintPause := 0;
  Application.HintHidePause := 50000;

  //ListBox1.Style := lbOwnerDrawFixed;
  ListBox1.ItemHeight := 16;
end;

// read the options
procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;
  ComboBox4.OnChange(sender);
  CheckBox1.OnClick(sender);
  CheckBox8.OnClick(sender);

end;

procedure TForm1.Label11Click(Sender: TObject);
begin
  if shellexecute(handle,'open','http://www.bzip.org/',nil,nil,sw_show)<=32
   then showmessage('The website could not be opened!');
end;

procedure TForm1.Label11MouseLeave(Sender: TObject);
begin
  Label11.Font.Color := clBlack;
   Label11.Font.Style := [];
end;

procedure TForm1.Label11MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label11.Font.Color := clBlue;
   Label11.Font.Style := [fsUnderline];
end;

procedure TForm1.Label12Click(Sender: TObject);
begin
  if shellexecute(handle,'open','https://www.gzip.org/',nil,nil,sw_show)<=32
   then showmessage('The website could not be opened!');
end;

procedure TForm1.Label12MouseLeave(Sender: TObject);
begin
  Label12.Font.Color := clBlack;
   Label12.Font.Style := [];
end;

procedure TForm1.Label12MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label12.Font.Color := clBlue;
   Label12.Font.Style := [fsUnderline];
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
  if shellexecute(handle,'open','https://www.nongnu.org/lzip/lzip.html',nil,nil,sw_show)<=32
   then showmessage('The website could not be opened!');
end;

procedure TForm1.Label2MouseLeave(Sender: TObject);
begin
  Label2.Font.Color := clBlack;
   Label2.Font.Style := [];
end;

procedure TForm1.Label2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label2.Font.Color := clBlue;
   Label2.Font.Style := [fsUnderline];
end;

procedure TForm1.Label6Click(Sender: TObject);
begin
  if shellexecute(handle,'open','https://www.nongnu.org/lzip/plzip.html',nil,nil,sw_show)<=32
   then showmessage('The website could not be opened!');
end;

procedure TForm1.Label6MouseLeave(Sender: TObject);
begin
  Label6.Font.Color := clBlack;
   Label6.Font.Style := [];
end;

procedure TForm1.Label6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Label6.Font.Color := clBlue;
   Label6.Font.Style := [fsUnderline];
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  Properties1.Click;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
 Len: Integer;
 NewText: String;
begin
  NewText := Listbox1.Items[Index];

  // draw horizontal scrollbar
  with Listbox1.Canvas do
  begin
    FillRect(Rect);
    TextOut(Rect.Left + 1, Rect.Top, NewText);
    Len := TextWidth(NewText) + Rect.Left + 10;
    if Len>flbHorzScrollWidth then
    begin
      flbHorzScrollWidth := Len;
      Listbox1.Perform(LB_SETHORIZONTALEXTENT, flbHorzScrollWidth, 0 );
    end;
  end;

  // draw the icons in the listbox
  DrawListBoxExtra(Control, Index, Rect, State);
end;

procedure TForm1.Pack1Click(Sender: TObject);
begin
  Button6.Click;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = TabSheet1 then
    ListBox1.SetFocus;
end;

procedure TForm1.Panel3Click(Sender: TObject);
begin
  Panel2.Visible := Panel3.Checked;
end;

procedure TForm1.Properties1Click(Sender: TObject);
begin
  PropertiesDialog(ListBox1.Items.Strings[ListBox1.ItemIndex]);
end;

end.
