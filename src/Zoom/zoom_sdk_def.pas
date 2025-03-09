unit zoom_sdk_def;

interface

uses
  Windows, SysUtils;

const
  PLATFORM_IMPORT = '__declspec(dllimport)';
  PLATFORM_EXPORT = '__declspec(dllexport)';

{$IFDEF ZOOM_SDK_DLL_EXPORT}
  SDK_API = PLATFORM_EXPORT;
{$ELSE}
  SDK_API = PLATFORM_IMPORT;
{$ENDIF}

  ENABLE_CUSTOMIZED_UI_FLAG = (1 shl 5);
  SDK_NULL_AUDIO_FILE_HANDLE = $FFFFFFFF;
  _SDK_TEST_VIDEO_INIT_RECT: TRect = (Left: 0; Top: 0; Right: 0; Bottom: 0);

type
  SDKError = (
    SDKERR_SUCCESS = 0,           // Success.
    SDKERR_NO_IMPL,               // This feature is currently invalid.
    SDKERR_WRONG_USEAGE,          // Incorrect usage of the feature.
    SDKERR_INVALID_PARAMETER,     // Wrong parameter.
    SDKERR_MODULE_LOAD_FAILED,    // Loading module failed.
    SDKERR_MEMORY_FAILED,         // No memory is allocated.
    SDKERR_SERVICE_FAILED,        // Internal service error.
    SDKERR_UNINITIALIZE,          // Not initialized before the usage.
    SDKERR_UNAUTHENTICATION,      // Not authorized before the usage.
    SDKERR_NORECORDINGINPROCESS,  // No recording in process.
    SDKERR_TRANSCODER_NOFOUND,    // Transcoder module is not found.
    SDKERR_VIDEO_NOTREADY,        // The video service is not ready.
    SDKERR_NO_PERMISSION,         // No permission.
    SDKERR_UNKNOWN,               // Unknown error.
    SDKERR_OTHER_SDK_INSTANCE_RUNNING, // The other instance of the SDK is in process.
    SDKERR_INTELNAL_ERROR,        // SDK internal error.
    SDKERR_NO_AUDIODEVICE_ISFOUND, // No audio device found.
    SDKERR_NO_VIDEODEVICE_ISFOUND, // No video device found.
    SDKERR_TOO_FREQUENT_CALL,     // API calls too frequently.
    SDKERR_FAIL_ASSIGN_USER_PRIVILEGE, // User can't be assigned with new privilege.
    SDKERR_MEETING_DONT_SUPPORT_FEATURE, // The current meeting doesn't support the feature.
    SDKERR_MEETING_NOT_SHARE_SENDER,    // The current user is not the presenter.
    SDKERR_MEETING_YOU_HAVE_NO_SHARE,   // There is no sharing.
    SDKERR_MEETING_VIEWTYPE_PARAMETER_IS_WRONG, // Incorrect ViewType parameters.
    SDKERR_MEETING_ANNOTATION_IS_OFF,   // Annotation is disabled.
    SDKERR_SETTING_OS_DONT_SUPPORT,     // Current OS doesn't support the setting.
    SDKERR_EMAIL_LOGIN_IS_DISABLED,     // Email login is disabled.
    SDKERR_HARDWARE_NOT_MEET_FOR_VB     // Computer doesn't meet the minimum requirements to use virtual background feature.
  );

  SDK_LANGUAGE_ID = (
    LANGUAGE_Unknow = 0,     // For initialization.
    LANGUAGE_English,        // In English.
    LANGUAGE_Chinese_Simplified,  // In simplified Chinese.
    LANGUAGE_Chinese_Traditional, // In traditional Chinese.
    LANGUAGE_Japanese,       // In Japanese.
    LANGUAGE_Spanish,        // In Spanish.
    LANGUAGE_German,         // In German.
    LANGUAGE_French,         // In French.
    LANGUAGE_Portuguese,     // In Portuguese.
    LANGUAGE_Russian,        // In Russian.
    LANGUAGE_Korean,         // In Korean.
    LANGUAGE_Vietnamese,     // In Vietnamese.
    LANGUAGE_Italian         // In Italian.
  );

  PWndPosition = ^WndPosition;
  WndPosition = record
    left: Integer;               // Specifies the X-axis coordinate of the top-left corner of the window
    top: Integer;                // Specifies the Y-axis coordinate of the top-left of the window.
    hSelfWnd: HWND;              // Specifies the window handle of the window itself.
    hParent: HWND;               // Specifies the window handle of the parent window. If the value is NULL, the position coordinate is the monitor coordinate.
//    constructor Create;
  end;

  CustomizedLanguageType = (
    CustomizedLanguage_None,      // No use of the custom resource.
    CustomizedLanguage_FilePath,  // Use the specified file path to assign the custom resource.
    CustomizedLanguage_Content    // Use the specified content to assign the custom resource.
  );

  PCustomizedLanguageInfo = ^CustomizedLanguageInfo;
  CustomizedLanguageInfo = record
    langName: PAnsiChar;          // Resource name.
    langInfo: PAnsiChar;          // The value should be the full path of the resource file when the langType value is CustomizedLanguage_FilePath, including the file name. When the langType value is CustomizedLanguage_Content, the value saves the content of the resource.
    langType: CustomizedLanguageType; // Use the custom resource type.
//    constructor Create;
  end;

  PConfigurableOptions = ^ConfigurableOptions;
  ConfigurableOptions = record
    customizedLang: CustomizedLanguageInfo; // The custom resource information.
    optionalFeatures: Integer;   // Additional functional configuration. The function currently supports whether to use the custom UI mode only. When the value of the optionalFeatures & ENABLE_CUSTOMIZED_UI_FLAG is TRUE, it means the custom UI mode will be used. Otherwise the Zoom UI mode will be used.
    sdkPathPostfix: PWideChar;
//    constructor Create;
  end;

  SDK_APP_Locale = (
    SDK_APP_Locale_Default,
    SDK_APP_Locale_CN
  );

  ZoomSDKRawDataMemoryMode = (
    ZoomSDKRawDataMemoryModeStack,
    ZoomSDKRawDataMemoryModeHeap
  );

  ZoomSDKVideoRenderMode = (
    ZoomSDKVideoRenderMode_None = 0,
    ZoomSDKVideoRenderMode_Auto,
    ZoomSDKVideoRenderMode_D3D11EnableFLIP,
    ZoomSDKVideoRenderMode_D3D11,
    ZoomSDKVideoRenderMode_D3D9,
    ZoomSDKVideoRenderMode_GDI
  );

  ZoomSDKRenderPostProcessing = (
    ZoomSDKRenderPostProcessing_None = 0,
    ZoomSDKRenderPostProcessing_Auto,
    ZoomSDKRenderPostProcessing_Enable,
    ZoomSDKRenderPostProcessing_Disable
  );

  ZoomSDKVideoCaptureMethod = (
    ZoomSDKVideoCaptureMethod_None = 0,
    ZoomSDKVideoCaptureMethod_Auto,
    ZoomSDKVideoCaptureMethod_DirectSHow,
    ZoomSDKVideoCaptureMethod_MediaFoundation
  );

  PZoomSDKRenderOptions = ^ZoomSDKRenderOptions;
  ZoomSDKRenderOptions = record
    videoRenderMode: ZoomSDKVideoRenderMode;
    renderPostProcessing: ZoomSDKRenderPostProcessing;
    videoCaptureMethod: ZoomSDKVideoCaptureMethod;
//    constructor Create;
  end;

  PRawDataOptions = ^RawDataOptions;
  RawDataOptions = record
    enableRawdataIntermediateMode: Boolean; // false -- YUV420data, true -- intermediate data
    videoRawdataMemoryMode: ZoomSDKRawDataMemoryMode;
    shareRawdataMemoryMode: ZoomSDKRawDataMemoryMode;
    audioRawdataMemoryMode: ZoomSDKRawDataMemoryMode;
//    constructor Create;
  end;

  PInitParam = ^InitParam;
  InitParam = record
    strWebDomain: PWideChar;            // Web domain.
    strBrandingName: PWideChar;         // Branding name.
    strSupportUrl: PWideChar;           // Support URL.
    hResInstance: Pointer;              // Resource module handle.
    uiWindowIconSmallID: Cardinal;      // The ID of the small icon on the window.
    uiWindowIconBigID: Cardinal;        // The ID of the big Icon on the window.
    emLanguageID: SDK_LANGUAGE_ID;      // The ID of the SDK language.
    enableGenerateDump: Boolean;        // Enable generate dump file if the app crashed.
    enableLogByDefault: Boolean;        // Enable log feature.
    uiLogFileSize: Cardinal;            // Size of a log file in M(megabyte). The default size is 5M. There are 5 log files in total and the file size varies from 1M to 50M.
    obConfigOpts: ConfigurableOptions;  // The configuration options of the SDK.
    locale: SDK_APP_Locale;
    permonitor_awareness_mode: Boolean;
    renderOpts: ZoomSDKRenderOptions;
    rawdataOpts: RawDataOptions;
//    constructor Create;
  end;

  LastErrorType = (
    LastErrorType_None,     // No error.
    LastErrorType_Auth,     // Error during verification.
    LastErrorType_Login,    // Error during login.
    LastErrorType_Meeting,  // The associated error with the meeting.
    LastErrorType_System    // The associated error with the SDK bottom layer.
  );

  IZoomLastError = interface

  end;

implementation

end.
