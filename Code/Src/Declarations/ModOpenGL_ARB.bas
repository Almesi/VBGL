Attribute VB_Name = "ModOpenGL_ARB"
Option Explicit
'***************************************************************************************
'*                   Module openGL ModOpenGL_OTHER
'***************************************************************************************
' http://arkham46.developpez.com
'***************************************************************************************
' G�n�r� le 23/05/2018 � partir de glew-2.1.0.h
'***************************************************************************************
#If VBA7 Then
DefLngPtr A-Z
#Else
DefLng A-Z
#End If
#If Win64 Then
Const vbLongPtr As Long = vbLongLong
#Else
Const vbLongPtr As Long = vbLong
#End If
'***************************************************************************************
'*                                    Constantes                                       *
'***************************************************************************************
'------------------------------- GL_ARB_ES2_compatibility -------------------------------
Public Const GL_FIXED                                 = &H140C&
Public Const GL_IMPLEMENTATION_COLOR_READ_TYPE        = &H8B9A&
Public Const GL_IMPLEMENTATION_COLOR_READ_FORMAT      = &H8B9B&
Public Const GL_RGB565                                = &H8D62&
Public Const GL_LOW_FLOAT                             = &H8DF0&
Public Const GL_MEDIUM_FLOAT                          = &H8DF1&
Public Const GL_HIGH_FLOAT                            = &H8DF2&
Public Const GL_LOW_INT                               = &H8DF3&
Public Const GL_MEDIUM_INT                            = &H8DF4&
Public Const GL_HIGH_INT                              = &H8DF5&
Public Const GL_SHADER_BINARY_FORMATS                 = &H8DF8&
Public Const GL_NUM_SHADER_BINARY_FORMATS             = &H8DF9&
Public Const GL_SHADER_COMPILER                       = &H8DFA&
Public Const GL_MAX_VERTEX_UNIFORM_VECTORS            = &H8DFB&
Public Const GL_MAX_VARYING_VECTORS                   = &H8DFC&
Public Const GL_MAX_FRAGMENT_UNIFORM_VECTORS          = &H8DFD&
'------------------------------- GL_ARB_ES3_1_compatibility -------------------------------
'------------------------------- GL_ARB_ES3_2_compatibility -------------------------------
Public Const GL_PRIMITIVE_BOUNDING_BOX_ARB                                                                                                                                                                                                               = &H92BE&
Public Const GL_MULTISAMPLE_LINE_WIDTH_RANGE_ARB                                                                                                                                                                                                                 = &H9381&
Public Const GL_MULTISAMPLE_LINE_WIDTH_GRANULARITY_ARB                                                                                                                                                                                                               = &H9382&
'------------------------------- GL_ARB_ES3_compatibility -------------------------------
Public Const GL_TEXTURE_IMMUTABLE_LEVELS                   = &H82DF&
Public Const GL_PRIMITIVE_RESTART_FIXED_INDEX              = &H8D69&
Public Const GL_ANY_SAMPLES_PASSED_CONSERVATIVE            = &H8D6A&
Public Const GL_MAX_ELEMENT_INDEX                          = &H8D6B&
Public Const GL_COMPRESSED_R11_EAC                         = &H9270&
Public Const GL_COMPRESSED_SIGNED_R11_EAC                  = &H9271&
Public Const GL_COMPRESSED_RG11_EAC                        = &H9272&
Public Const GL_COMPRESSED_SIGNED_RG11_EAC                 = &H9273&
Public Const GL_COMPRESSED_RGB8_ETC2                       = &H9274&
Public Const GL_COMPRESSED_SRGB8_ETC2                      = &H9275&
Public Const GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2   = &H9276&
Public Const GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2  = &H9277&
Public Const GL_COMPRESSED_RGBA8_ETC2_EAC                  = &H9278&
Public Const GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC           = &H9279&
'------------------------------- GL_ARB_arrays_of_arrays -------------------------------
'------------------------------- GL_ARB_base_instance -------------------------------
'------------------------------- GL_ARB_bindless_texture -------------------------------
Public Const GL_UNSIGNED_INT64_ARB                         = &H140F&
'------------------------------- GL_ARB_blend_func_extended -------------------------------
Public Const GL_SRC1_COLOR                                 = &H88F9&
Public Const GL_ONE_MINUS_SRC1_COLOR                       = &H88FA&
Public Const GL_ONE_MINUS_SRC1_ALPHA                       = &H88FB&
Public Const GL_MAX_DUAL_SOURCE_DRAW_BUFFERS               = &H88FC&
'------------------------------- GL_ARB_buffer_storage -------------------------------
Public Const GL_MAP_READ_BIT                               = &H1&
Public Const GL_MAP_WRITE_BIT                              = &H2&
Public Const GL_MAP_PERSISTENT_BIT                         = &H40&
Public Const GL_MAP_COHERENT_BIT                           = &H80&
Public Const GL_DYNAMIC_STORAGE_BIT                        = &H100&
Public Const GL_CLIENT_STORAGE_BIT                         = &H200&
Public Const GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT           = &H4000&
Public Const GL_BUFFER_IMMUTABLE_STORAGE                   = &H821F&
Public Const GL_BUFFER_STORAGE_FLAGS                       = &H8220&
'------------------------------- GL_ARB_cl_event -------------------------------
Public Const GL_SYNC_CL_EVENT_ARB                          = &H8240&
Public Const GL_SYNC_CL_EVENT_COMPLETE_ARB                 = &H8241&
'------------------------------- GL_ARB_clear_buffer_object -------------------------------
'------------------------------- GL_ARB_clear_texture -------------------------------
Public Const GL_CLEAR_TEXTURE                              = &H9365&
'------------------------------- GL_ARB_clip_control -------------------------------
'public const GL_LOWER_LEFT                                                                                                                                                                                                              = &h8CA1&
'public const GL_UPPER_LEFT                                                                                                                                                                                                              = &h8CA2&
Public Const GL_CLIP_ORIGIN                                = &H935C&
Public Const GL_CLIP_DEPTH_MODE                            = &H935D&
Public Const GL_NEGATIVE_ONE_TO_ONE                        = &H935E&
Public Const GL_ZERO_TO_ONE                                = &H935F&
'------------------------------- GL_ARB_color_buffer_float -------------------------------
Public Const GL_RGBA_FLOAT_MODE_ARB                                                                                                                                                                                                              = &H8820&
Public Const GL_CLAMP_VERTEX_COLOR_ARB                                                                                                                                                                                                               = &H891A&
Public Const GL_CLAMP_FRAGMENT_COLOR_ARB                                                                                                                                                                                                                 = &H891B&
Public Const GL_CLAMP_READ_COLOR_ARB                                                                                                                                                                                                                 = &H891C&
Public Const GL_FIXED_ONLY_ARB                                                                                                                                                                                                               = &H891D&
'------------------------------- GL_ARB_compatibility -------------------------------
'------------------------------- GL_ARB_compressed_texture_pixel_storage -------------------------------
Public Const GL_UNPACK_COMPRESSED_BLOCK_WIDTH              = &H9127&
Public Const GL_UNPACK_COMPRESSED_BLOCK_HEIGHT             = &H9128&
Public Const GL_UNPACK_COMPRESSED_BLOCK_DEPTH              = &H9129&
Public Const GL_UNPACK_COMPRESSED_BLOCK_SIZE               = &H912A&
Public Const GL_PACK_COMPRESSED_BLOCK_WIDTH                = &H912B&
Public Const GL_PACK_COMPRESSED_BLOCK_HEIGHT               = &H912C&
Public Const GL_PACK_COMPRESSED_BLOCK_DEPTH                = &H912D&
Public Const GL_PACK_COMPRESSED_BLOCK_SIZE                 = &H912E&
'------------------------------- GL_ARB_compute_shader -------------------------------
Public Const GL_COMPUTE_SHADER_BIT                                   = &H20&
Public Const GL_MAX_COMPUTE_SHARED_MEMORY_SIZE                       = &H8262&
Public Const GL_MAX_COMPUTE_UNIFORM_COMPONENTS                       = &H8263&
Public Const GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS                   = &H8264&
Public Const GL_MAX_COMPUTE_ATOMIC_COUNTERS                          = &H8265&
Public Const GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS              = &H8266&
Public Const GL_COMPUTE_WORK_GROUP_SIZE                              = &H8267&
Public Const GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS                   = &H90EB&
Public Const GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER           = &H90EC&
Public Const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER   = &H90ED&
Public Const GL_DISPATCH_INDIRECT_BUFFER                             = &H90EE&
Public Const GL_DISPATCH_INDIRECT_BUFFER_BINDING                     = &H90EF&
Public Const GL_COMPUTE_SHADER                                       = &H91B9&
Public Const GL_MAX_COMPUTE_UNIFORM_BLOCKS                           = &H91BB&
Public Const GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS                      = &H91BC&
Public Const GL_MAX_COMPUTE_IMAGE_UNIFORMS                           = &H91BD&
Public Const GL_MAX_COMPUTE_WORK_GROUP_COUNT                         = &H91BE&
Public Const GL_MAX_COMPUTE_WORK_GROUP_SIZE                          = &H91BF&
'------------------------------- GL_ARB_compute_variable_group_size -------------------------------
Public Const GL_MAX_COMPUTE_FIXED_GROUP_INVOCATIONS_ARB                                                                                                                                                                                                              = &H90EB&
Public Const GL_MAX_COMPUTE_FIXED_GROUP_SIZE_ARB                                                                                                                                                                                                                 = &H91BF&
Public Const GL_MAX_COMPUTE_VARIABLE_GROUP_INVOCATIONS_ARB                                                                                                                                                                                                               = &H9344&
Public Const GL_MAX_COMPUTE_VARIABLE_GROUP_SIZE_ARB                                                                                                                                                                                                              = &H9345&
'------------------------------- GL_ARB_conditional_render_inverted -------------------------------
Public Const GL_QUERY_WAIT_INVERTED                                                                                                                                                                                                              = &H8E17&
Public Const GL_QUERY_NO_WAIT_INVERTED                                                                                                                                                                                                               = &H8E18&
Public Const GL_QUERY_BY_REGION_WAIT_INVERTED                                                                                                                                                                                                                = &H8E19&
Public Const GL_QUERY_BY_REGION_NO_WAIT_INVERTED                                                                                                                                                                                                                 = &H8E1A&
'------------------------------- GL_ARB_conservative_depth -------------------------------
'------------------------------- GL_ARB_copy_buffer -------------------------------
Public Const GL_COPY_READ_BUFFER                                                                                                                                                                                                                 = &H8F36&
Public Const GL_COPY_WRITE_BUFFER                                                                                                                                                                                                                = &H8F37&
'------------------------------- GL_ARB_copy_image -------------------------------
'------------------------------- GL_ARB_cull_distance -------------------------------
Public Const GL_MAX_CULL_DISTANCES                                                                                                                                                                                                               = &H82F9&
Public Const GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES                                                                                                                                                                                                                 = &H82FA&
'------------------------------- GL_ARB_debug_output -------------------------------
Public Const GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB                                                                                                                                                                                                                 = &H8242&
Public Const GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB                                                                                                                                                                                                                 = &H8243&
Public Const GL_DEBUG_CALLBACK_FUNCTION_ARB                                                                                                                                                                                                              = &H8244&
Public Const GL_DEBUG_CALLBACK_USER_PARAM_ARB                                                                                                                                                                                                                = &H8245&
Public Const GL_DEBUG_SOURCE_API_ARB                                                                                                                                                                                                                 = &H8246&
Public Const GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB                                                                                                                                                                                                               = &H8247&
Public Const GL_DEBUG_SOURCE_SHADER_COMPILER_ARB                                                                                                                                                                                                                 = &H8248&
Public Const GL_DEBUG_SOURCE_THIRD_PARTY_ARB                                                                                                                                                                                                                 = &H8249&
Public Const GL_DEBUG_SOURCE_APPLICATION_ARB                                                                                                                                                                                                                 = &H824A&
Public Const GL_DEBUG_SOURCE_OTHER_ARB                                                                                                                                                                                                               = &H824B&
Public Const GL_DEBUG_TYPE_ERROR_ARB                                                                                                                                                                                                                 = &H824C&
Public Const GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB                                                                                                                                                                                                               = &H824D&
Public Const GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB                                                                                                                                                                                                                = &H824E&
Public Const GL_DEBUG_TYPE_PORTABILITY_ARB                                                                                                                                                                                                               = &H824F&
Public Const GL_DEBUG_TYPE_PERFORMANCE_ARB                                                                                                                                                                                                               = &H8250&
Public Const GL_DEBUG_TYPE_OTHER_ARB                                                                                                                                                                                                                 = &H8251&
Public Const GL_MAX_DEBUG_MESSAGE_LENGTH_ARB                                                                                                                                                                                                                 = &H9143&
Public Const GL_MAX_DEBUG_LOGGED_MESSAGES_ARB                                                                                                                                                                                                                = &H9144&
Public Const GL_DEBUG_LOGGED_MESSAGES_ARB                                                                                                                                                                                                                = &H9145&
Public Const GL_DEBUG_SEVERITY_HIGH_ARB                                                                                                                                                                                                              = &H9146&
Public Const GL_DEBUG_SEVERITY_MEDIUM_ARB                                                                                                                                                                                                                = &H9147&
Public Const GL_DEBUG_SEVERITY_LOW_ARB                                                                                                                                                                                                               = &H9148&
'------------------------------- GL_ARB_depth_buffer_float -------------------------------
Public Const GL_DEPTH_COMPONENT32F                                                                                                                                                                                                               = &H8CAC&
Public Const GL_DEPTH32F_STENCIL8                                                                                                                                                                                                                = &H8CAD&
Public Const GL_FLOAT_32_UNSIGNED_INT_24_8_REV                                                                                                                                                                                                               = &H8DAD&
'------------------------------- GL_ARB_depth_clamp -------------------------------
Public Const GL_DEPTH_CLAMP                                                                                                                                                                                                              = &H864F&
'------------------------------- GL_ARB_depth_texture -------------------------------
Public Const GL_DEPTH_COMPONENT16_ARB                                                                                                                                                                                                                = &H81A5&
Public Const GL_DEPTH_COMPONENT24_ARB                                                                                                                                                                                                                = &H81A6&
Public Const GL_DEPTH_COMPONENT32_ARB                                                                                                                                                                                                                = &H81A7&
Public Const GL_TEXTURE_DEPTH_SIZE_ARB                                                                                                                                                                                                               = &H884A&
Public Const GL_DEPTH_TEXTURE_MODE_ARB                                                                                                                                                                                                               = &H884B&
'------------------------------- GL_ARB_derivative_control -------------------------------
'------------------------------- GL_ARB_direct_state_access -------------------------------
Public Const GL_TEXTURE_TARGET                                                                                                                                                                                                               = &H1006&
Public Const GL_QUERY_TARGET                                                                                                                                                                                                                 = &H82EA&
'------------------------------- GL_ARB_draw_buffers -------------------------------
Public Const GL_MAX_DRAW_BUFFERS_ARB                                                                                                                                                                                                                 = &H8824&
Public Const GL_DRAW_BUFFER0_ARB                                                                                                                                                                                                                 = &H8825&
Public Const GL_DRAW_BUFFER1_ARB                                                                                                                                                                                                                 = &H8826&
Public Const GL_DRAW_BUFFER2_ARB                                                                                                                                                                                                                 = &H8827&
Public Const GL_DRAW_BUFFER3_ARB                                                                                                                                                                                                                 = &H8828&
Public Const GL_DRAW_BUFFER4_ARB                                                                                                                                                                                                                 = &H8829&
Public Const GL_DRAW_BUFFER5_ARB                                                                                                                                                                                                                 = &H882A&
Public Const GL_DRAW_BUFFER6_ARB                                                                                                                                                                                                                 = &H882B&
Public Const GL_DRAW_BUFFER7_ARB                                                                                                                                                                                                                 = &H882C&
Public Const GL_DRAW_BUFFER8_ARB                                                                                                                                                                                                                 = &H882D&
Public Const GL_DRAW_BUFFER9_ARB                                                                                                                                                                                                                 = &H882E&
Public Const GL_DRAW_BUFFER10_ARB                                                                                                                                                                                                                = &H882F&
Public Const GL_DRAW_BUFFER11_ARB                                                                                                                                                                                                                = &H8830&
Public Const GL_DRAW_BUFFER12_ARB                                                                                                                                                                                                                = &H8831&
Public Const GL_DRAW_BUFFER13_ARB                                                                                                                                                                                                                = &H8832&
Public Const GL_DRAW_BUFFER14_ARB                                                                                                                                                                                                                = &H8833&
Public Const GL_DRAW_BUFFER15_ARB                                                                                                                                                                                                                = &H8834&
'------------------------------- GL_ARB_draw_buffers_blend -------------------------------
'------------------------------- GL_ARB_draw_elements_base_vertex -------------------------------
'------------------------------- GL_ARB_draw_indirect -------------------------------
Public Const GL_DRAW_INDIRECT_BUFFER                                                                                                                                                                                                                 = &H8F3F&
Public Const GL_DRAW_INDIRECT_BUFFER_BINDING                                                                                                                                                                                                                 = &H8F43&
'------------------------------- GL_ARB_draw_instanced -------------------------------
'------------------------------- GL_ARB_enhanced_layouts -------------------------------
Public Const GL_LOCATION_COMPONENT                                                                                                                                                                                                               = &H934A&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER_INDEX                                                                                                                                                                                                              = &H934B&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE                                                                                                                                                                                                                 = &H934C&
'------------------------------- GL_ARB_explicit_attrib_location -------------------------------
'------------------------------- GL_ARB_explicit_uniform_location -------------------------------
Public Const GL_MAX_UNIFORM_LOCATIONS                                                                                                                                                                                                                = &H826E&
'------------------------------- GL_ARB_fragment_coord_conventions -------------------------------
'------------------------------- GL_ARB_fragment_layer_viewport -------------------------------
'------------------------------- GL_ARB_fragment_program -------------------------------
Public Const GL_FRAGMENT_PROGRAM_ARB                                                                                                                                                                                                                 = &H8804&
Public Const GL_PROGRAM_ALU_INSTRUCTIONS_ARB                                                                                                                                                                                                                 = &H8805&
Public Const GL_PROGRAM_TEX_INSTRUCTIONS_ARB                                                                                                                                                                                                                 = &H8806&
Public Const GL_PROGRAM_TEX_INDIRECTIONS_ARB                                                                                                                                                                                                                 = &H8807&
Public Const GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB                                                                                                                                                                                                              = &H8808&
Public Const GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB                                                                                                                                                                                                              = &H8809&
Public Const GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB                                                                                                                                                                                                              = &H880A&
Public Const GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB                                                                                                                                                                                                                 = &H880B&
Public Const GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB                                                                                                                                                                                                                 = &H880C&
Public Const GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB                                                                                                                                                                                                                 = &H880D&
Public Const GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB                                                                                                                                                                                                              = &H880E&
Public Const GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB                                                                                                                                                                                                              = &H880F&
Public Const GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB                                                                                                                                                                                                              = &H8810&
Public Const GL_MAX_TEXTURE_COORDS_ARB                                                                                                                                                                                                               = &H8871&
Public Const GL_MAX_TEXTURE_IMAGE_UNITS_ARB                                                                                                                                                                                                              = &H8872&
'------------------------------- GL_ARB_fragment_program_shadow -------------------------------
'------------------------------- GL_ARB_fragment_shader -------------------------------
Public Const GL_FRAGMENT_SHADER_ARB                                                                                                                                                                                                              = &H8B30&
Public Const GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB                                                                                                                                                                                                              = &H8B49&
Public Const GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB                                                                                                                                                                                                              = &H8B8B&
'------------------------------- GL_ARB_fragment_shader_interlock -------------------------------
'------------------------------- GL_ARB_framebuffer_no_attachments -------------------------------
Public Const GL_FRAMEBUFFER_DEFAULT_WIDTH                                                                                                                                                                                                                = &H9310&
Public Const GL_FRAMEBUFFER_DEFAULT_HEIGHT                                                                                                                                                                                                               = &H9311&
Public Const GL_FRAMEBUFFER_DEFAULT_LAYERS                                                                                                                                                                                                               = &H9312&
Public Const GL_FRAMEBUFFER_DEFAULT_SAMPLES                                                                                                                                                                                                              = &H9313&
Public Const GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS                                                                                                                                                                                                               = &H9314&
Public Const GL_MAX_FRAMEBUFFER_WIDTH                                                                                                                                                                                                                = &H9315&
Public Const GL_MAX_FRAMEBUFFER_HEIGHT                                                                                                                                                                                                               = &H9316&
Public Const GL_MAX_FRAMEBUFFER_LAYERS                                                                                                                                                                                                               = &H9317&
Public Const GL_MAX_FRAMEBUFFER_SAMPLES                                                                                                                                                                                                              = &H9318&
'------------------------------- GL_ARB_framebuffer_object -------------------------------
Public Const GL_INVALID_FRAMEBUFFER_OPERATION                                                                                                                                                                                                                = &H506&
Public Const GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING                                                                                                                                                                                                                = &H8210&
Public Const GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE                                                                                                                                                                                                                = &H8211&
Public Const GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE                                                                                                                                                                                                              = &H8212&
Public Const GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE                                                                                                                                                                                                                = &H8213&
Public Const GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE                                                                                                                                                                                                                 = &H8214&
Public Const GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE                                                                                                                                                                                                                = &H8215&
Public Const GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE                                                                                                                                                                                                                = &H8216&
Public Const GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE                                                                                                                                                                                                              = &H8217&
Public Const GL_FRAMEBUFFER_DEFAULT                                                                                                                                                                                                              = &H8218&
Public Const GL_FRAMEBUFFER_UNDEFINED                                                                                                                                                                                                                = &H8219&
Public Const GL_DEPTH_STENCIL_ATTACHMENT                                                                                                                                                                                                                 = &H821A&
Public Const GL_INDEX                                                                                                                                                                                                                = &H8222&
Public Const GL_MAX_RENDERBUFFER_SIZE                                                                                                                                                                                                                = &H84E8&
Public Const GL_DEPTH_STENCIL                                                                                                                                                                                                                = &H84F9&
Public Const GL_UNSIGNED_INT_24_8                                                                                                                                                                                                                = &H84FA&
Public Const GL_DEPTH24_STENCIL8                                                                                                                                                                                                                 = &H88F0&
Public Const GL_TEXTURE_STENCIL_SIZE                                                                                                                                                                                                                 = &H88F1&
Public Const GL_UNSIGNED_NORMALIZED                                                                                                                                                                                                              = &H8C17&
'public const GL_SRGB                                                                                                                                                                                                                = &h8C40&
Public Const GL_DRAW_FRAMEBUFFER_BINDING                                                                                                                                                                                                                 = &H8CA6&
Public Const GL_FRAMEBUFFER_BINDING                                                                                                                                                                                                              = &H8CA6&
Public Const GL_RENDERBUFFER_BINDING                                                                                                                                                                                                                 = &H8CA7&
Public Const GL_READ_FRAMEBUFFER                                                                                                                                                                                                                 = &H8CA8&
Public Const GL_DRAW_FRAMEBUFFER                                                                                                                                                                                                                 = &H8CA9&
Public Const GL_READ_FRAMEBUFFER_BINDING                                                                                                                                                                                                                 = &H8CAA&
Public Const GL_RENDERBUFFER_SAMPLES                                                                                                                                                                                                                 = &H8CAB&
Public Const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE                                                                                                                                                                                                               = &H8CD0&
Public Const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME                                                                                                                                                                                                               = &H8CD1&
Public Const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL                                                                                                                                                                                                                 = &H8CD2&
Public Const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE                                                                                                                                                                                                                 = &H8CD3&
Public Const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER                                                                                                                                                                                                                 = &H8CD4&
Public Const GL_FRAMEBUFFER_COMPLETE                                                                                                                                                                                                                 = &H8CD5&
Public Const GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT                                                                                                                                                                                                                = &H8CD6&
Public Const GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT                                                                                                                                                                                                                = &H8CD7&
Public Const GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER                                                                                                                                                                                                               = &H8CDB&
Public Const GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER                                                                                                                                                                                                               = &H8CDC&
Public Const GL_FRAMEBUFFER_UNSUPPORTED                                                                                                                                                                                                              = &H8CDD&
Public Const GL_MAX_COLOR_ATTACHMENTS                                                                                                                                                                                                                = &H8CDF&
Public Const GL_COLOR_ATTACHMENT0                                                                                                                                                                                                                = &H8CE0&
Public Const GL_COLOR_ATTACHMENT1                                                                                                                                                                                                                = &H8CE1&
Public Const GL_COLOR_ATTACHMENT2                                                                                                                                                                                                                = &H8CE2&
Public Const GL_COLOR_ATTACHMENT3                                                                                                                                                                                                                = &H8CE3&
Public Const GL_COLOR_ATTACHMENT4                                                                                                                                                                                                                = &H8CE4&
Public Const GL_COLOR_ATTACHMENT5                                                                                                                                                                                                                = &H8CE5&
Public Const GL_COLOR_ATTACHMENT6                                                                                                                                                                                                                = &H8CE6&
Public Const GL_COLOR_ATTACHMENT7                                                                                                                                                                                                                = &H8CE7&
Public Const GL_COLOR_ATTACHMENT8                                                                                                                                                                                                                = &H8CE8&
Public Const GL_COLOR_ATTACHMENT9                                                                                                                                                                                                                = &H8CE9&
Public Const GL_COLOR_ATTACHMENT10                                                                                                                                                                                                               = &H8CEA&
Public Const GL_COLOR_ATTACHMENT11                                                                                                                                                                                                               = &H8CEB&
Public Const GL_COLOR_ATTACHMENT12                                                                                                                                                                                                               = &H8CEC&
Public Const GL_COLOR_ATTACHMENT13                                                                                                                                                                                                               = &H8CED&
Public Const GL_COLOR_ATTACHMENT14                                                                                                                                                                                                               = &H8CEE&
Public Const GL_COLOR_ATTACHMENT15                                                                                                                                                                                                               = &H8CEF&
Public Const GL_DEPTH_ATTACHMENT                                                                                                                                                                                                                 = &H8D00&
Public Const GL_STENCIL_ATTACHMENT                                                                                                                                                                                                               = &H8D20&
Public Const GL_FRAMEBUFFER                                                                                                                                                                                                              = &H8D40&
Public Const GL_RENDERBUFFER                                                                                                                                                                                                                 = &H8D41&
Public Const GL_RENDERBUFFER_WIDTH                                                                                                                                                                                                               = &H8D42&
Public Const GL_RENDERBUFFER_HEIGHT                                                                                                                                                                                                              = &H8D43&
Public Const GL_RENDERBUFFER_INTERNAL_FORMAT                                                                                                                                                                                                                 = &H8D44&
Public Const GL_STENCIL_INDEX1                                                                                                                                                                                                               = &H8D46&
Public Const GL_STENCIL_INDEX4                                                                                                                                                                                                               = &H8D47&
Public Const GL_STENCIL_INDEX8                                                                                                                                                                                                               = &H8D48&
Public Const GL_STENCIL_INDEX16                                                                                                                                                                                                              = &H8D49&
Public Const GL_RENDERBUFFER_RED_SIZE                                                                                                                                                                                                                = &H8D50&
Public Const GL_RENDERBUFFER_GREEN_SIZE                                                                                                                                                                                                              = &H8D51&
Public Const GL_RENDERBUFFER_BLUE_SIZE                                                                                                                                                                                                               = &H8D52&
Public Const GL_RENDERBUFFER_ALPHA_SIZE                                                                                                                                                                                                              = &H8D53&
Public Const GL_RENDERBUFFER_DEPTH_SIZE                                                                                                                                                                                                              = &H8D54&
Public Const GL_RENDERBUFFER_STENCIL_SIZE                                                                                                                                                                                                                = &H8D55&
Public Const GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE                                                                                                                                                                                                               = &H8D56&
Public Const GL_MAX_SAMPLES                                                                                                                                                                                                              = &H8D57&
'------------------------------- GL_ARB_framebuffer_sRGB -------------------------------
Public Const GL_FRAMEBUFFER_SRGB                                                                                                                                                                                                                 = &H8DB9&
'------------------------------- GL_ARB_geometry_shader4 -------------------------------
Public Const GL_LINES_ADJACENCY_ARB                                                                                                                                                                                                              = &HA&
Public Const GL_LINE_STRIP_ADJACENCY_ARB                                                                                                                                                                                                                 = &HB&
Public Const GL_TRIANGLES_ADJACENCY_ARB                                                                                                                                                                                                              = &HC&
Public Const GL_TRIANGLE_STRIP_ADJACENCY_ARB                                                                                                                                                                                                                 = &HD&
Public Const GL_PROGRAM_POINT_SIZE_ARB                                                                                                                                                                                                               = &H8642&
Public Const GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB                                                                                                                                                                                                                 = &H8C29&
'public const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER                                                                                                                                                                                                                = &h8CD4&
Public Const GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB                                                                                                                                                                                                               = &H8DA7&
Public Const GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB                                                                                                                                                                                                                 = &H8DA8&
Public Const GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB                                                                                                                                                                                                               = &H8DA9&
Public Const GL_GEOMETRY_SHADER_ARB                                                                                                                                                                                                              = &H8DD9&
Public Const GL_GEOMETRY_VERTICES_OUT_ARB                                                                                                                                                                                                                = &H8DDA&
Public Const GL_GEOMETRY_INPUT_TYPE_ARB                                                                                                                                                                                                              = &H8DDB&
Public Const GL_GEOMETRY_OUTPUT_TYPE_ARB                                                                                                                                                                                                                 = &H8DDC&
Public Const GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB                                                                                                                                                                                                              = &H8DDD&
Public Const GL_MAX_VERTEX_VARYING_COMPONENTS_ARB                                                                                                                                                                                                                = &H8DDE&
Public Const GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB                                                                                                                                                                                                              = &H8DDF&
Public Const GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB                                                                                                                                                                                                                 = &H8DE0&
Public Const GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB                                                                                                                                                                                                                 = &H8DE1&
'------------------------------- GL_ARB_get_program_binary -------------------------------
Public Const GL_PROGRAM_BINARY_RETRIEVABLE_HINT                                                                                                                                                                                                              = &H8257&
Public Const GL_PROGRAM_BINARY_LENGTH                                                                                                                                                                                                                = &H8741&
Public Const GL_NUM_PROGRAM_BINARY_FORMATS                                                                                                                                                                                                               = &H87FE&
Public Const GL_PROGRAM_BINARY_FORMATS                                                                                                                                                                                                               = &H87FF&
'------------------------------- GL_ARB_get_texture_sub_image -------------------------------
'------------------------------- GL_ARB_gl_spirv -------------------------------
Public Const GL_SHADER_BINARY_FORMAT_SPIR_V_ARB                                                                                                                                                                                                              = &H9551&
Public Const GL_SPIR_V_BINARY_ARB                                                                                                                                                                                                                = &H9552&
'------------------------------- GL_ARB_gpu_shader5 -------------------------------
Public Const GL_GEOMETRY_SHADER_INVOCATIONS                                                                                                                                                                                                              = &H887F&
Public Const GL_MAX_GEOMETRY_SHADER_INVOCATIONS                                                                                                                                                                                                              = &H8E5A&
Public Const GL_MIN_FRAGMENT_INTERPOLATION_OFFSET                                                                                                                                                                                                                = &H8E5B&
Public Const GL_MAX_FRAGMENT_INTERPOLATION_OFFSET                                                                                                                                                                                                                = &H8E5C&
Public Const GL_FRAGMENT_INTERPOLATION_OFFSET_BITS                                                                                                                                                                                                               = &H8E5D&
Public Const GL_MAX_VERTEX_STREAMS                                                                                                                                                                                                               = &H8E71&
'------------------------------- GL_ARB_gpu_shader_fp64 -------------------------------
Public Const GL_DOUBLE_MAT2                                                                                                                                                                                                              = &H8F46&
Public Const GL_DOUBLE_MAT3                                                                                                                                                                                                              = &H8F47&
Public Const GL_DOUBLE_MAT4                                                                                                                                                                                                              = &H8F48&
Public Const GL_DOUBLE_MAT2x3                                                                                                                                                                                                                = &H8F49&
Public Const GL_DOUBLE_MAT2x4                                                                                                                                                                                                                = &H8F4A&
Public Const GL_DOUBLE_MAT3x2                                                                                                                                                                                                                = &H8F4B&
Public Const GL_DOUBLE_MAT3x4                                                                                                                                                                                                                = &H8F4C&
Public Const GL_DOUBLE_MAT4x2                                                                                                                                                                                                                = &H8F4D&
Public Const GL_DOUBLE_MAT4x3                                                                                                                                                                                                                = &H8F4E&
Public Const GL_DOUBLE_VEC2                                                                                                                                                                                                              = &H8FFC&
Public Const GL_DOUBLE_VEC3                                                                                                                                                                                                              = &H8FFD&
Public Const GL_DOUBLE_VEC4                                                                                                                                                                                                              = &H8FFE&
'------------------------------- GL_ARB_gpu_shader_int64 -------------------------------
Public Const GL_INT64_ARB                                                                                                                                                                                                                = &H140E&
'public const GL_UNSIGNED_INT64_ARB                                                                                                                                                                                                              = &h140F&
Public Const GL_INT64_VEC2_ARB                                                                                                                                                                                                               = &H8FE9&
Public Const GL_INT64_VEC3_ARB                                                                                                                                                                                                               = &H8FEA&
Public Const GL_INT64_VEC4_ARB                                                                                                                                                                                                               = &H8FEB&
Public Const GL_UNSIGNED_INT64_VEC2_ARB                                                                                                                                                                                                              = &H8FF5&
Public Const GL_UNSIGNED_INT64_VEC3_ARB                                                                                                                                                                                                              = &H8FF6&
Public Const GL_UNSIGNED_INT64_VEC4_ARB                                                                                                                                                                                                              = &H8FF7&
'------------------------------- GL_ARB_half_float_pixel -------------------------------
Public Const GL_HALF_FLOAT_ARB                                                                                                                                                                                                               = &H140B&
'------------------------------- GL_ARB_half_float_vertex -------------------------------
Public Const GL_HALF_FLOAT                                                                                                                                                                                                               = &H140B&
'------------------------------- GL_ARB_imaging -------------------------------
Public Const GL_CONSTANT_COLOR                                                                                                                                                                                                               = &H8001&
Public Const GL_ONE_MINUS_CONSTANT_COLOR                                                                                                                                                                                                                 = &H8002&
Public Const GL_CONSTANT_ALPHA                                                                                                                                                                                                               = &H8003&
Public Const GL_ONE_MINUS_CONSTANT_ALPHA                                                                                                                                                                                                                 = &H8004&
Public Const GL_BLEND_COLOR                                                                                                                                                                                                              = &H8005&
Public Const GL_FUNC_ADD                                                                                                                                                                                                                 = &H8006&
Public Const GL_MIN                                                                                                                                                                                                              = &H8007&
Public Const GL_MAX                                                                                                                                                                                                              = &H8008&
Public Const GL_BLEND_EQUATION                                                                                                                                                                                                               = &H8009&
Public Const GL_FUNC_SUBTRACT                                                                                                                                                                                                                = &H800A&
Public Const GL_FUNC_REVERSE_SUBTRACT                                                                                                                                                                                                                = &H800B&
Public Const GL_CONVOLUTION_1D                                                                                                                                                                                                               = &H8010&
Public Const GL_CONVOLUTION_2D                                                                                                                                                                                                               = &H8011&
Public Const GL_SEPARABLE_2D                                                                                                                                                                                                                 = &H8012&
Public Const GL_CONVOLUTION_BORDER_MODE                                                                                                                                                                                                              = &H8013&
Public Const GL_CONVOLUTION_FILTER_SCALE                                                                                                                                                                                                                 = &H8014&
Public Const GL_CONVOLUTION_FILTER_BIAS                                                                                                                                                                                                              = &H8015&
Public Const GL_REDUCE                                                                                                                                                                                                               = &H8016&
Public Const GL_CONVOLUTION_FORMAT                                                                                                                                                                                                               = &H8017&
Public Const GL_CONVOLUTION_WIDTH                                                                                                                                                                                                                = &H8018&
Public Const GL_CONVOLUTION_HEIGHT                                                                                                                                                                                                               = &H8019&
Public Const GL_MAX_CONVOLUTION_WIDTH                                                                                                                                                                                                                = &H801A&
Public Const GL_MAX_CONVOLUTION_HEIGHT                                                                                                                                                                                                               = &H801B&
Public Const GL_POST_CONVOLUTION_RED_SCALE                                                                                                                                                                                                               = &H801C&
Public Const GL_POST_CONVOLUTION_GREEN_SCALE                                                                                                                                                                                                                 = &H801D&
Public Const GL_POST_CONVOLUTION_BLUE_SCALE                                                                                                                                                                                                              = &H801E&
Public Const GL_POST_CONVOLUTION_ALPHA_SCALE                                                                                                                                                                                                                 = &H801F&
Public Const GL_POST_CONVOLUTION_RED_BIAS                                                                                                                                                                                                                = &H8020&
Public Const GL_POST_CONVOLUTION_GREEN_BIAS                                                                                                                                                                                                              = &H8021&
Public Const GL_POST_CONVOLUTION_BLUE_BIAS                                                                                                                                                                                                               = &H8022&
Public Const GL_POST_CONVOLUTION_ALPHA_BIAS                                                                                                                                                                                                              = &H8023&
Public Const GL_HISTOGRAM                                                                                                                                                                                                                = &H8024&
Public Const GL_PROXY_HISTOGRAM                                                                                                                                                                                                              = &H8025&
Public Const GL_HISTOGRAM_WIDTH                                                                                                                                                                                                              = &H8026&
Public Const GL_HISTOGRAM_FORMAT                                                                                                                                                                                                                 = &H8027&
Public Const GL_HISTOGRAM_RED_SIZE                                                                                                                                                                                                               = &H8028&
Public Const GL_HISTOGRAM_GREEN_SIZE                                                                                                                                                                                                                 = &H8029&
Public Const GL_HISTOGRAM_BLUE_SIZE                                                                                                                                                                                                              = &H802A&
Public Const GL_HISTOGRAM_ALPHA_SIZE                                                                                                                                                                                                                 = &H802B&
Public Const GL_HISTOGRAM_LUMINANCE_SIZE                                                                                                                                                                                                                 = &H802C&
Public Const GL_HISTOGRAM_SINK                                                                                                                                                                                                               = &H802D&
Public Const GL_MINMAX                                                                                                                                                                                                               = &H802E&
Public Const GL_MINMAX_FORMAT                                                                                                                                                                                                                = &H802F&
Public Const GL_MINMAX_SINK                                                                                                                                                                                                              = &H8030&
Public Const GL_TABLE_TOO_LARGE                                                                                                                                                                                                              = &H8031&
Public Const GL_COLOR_MATRIX                                                                                                                                                                                                                 = &H80B1&
Public Const GL_COLOR_MATRIX_STACK_DEPTH                                                                                                                                                                                                                 = &H80B2&
Public Const GL_MAX_COLOR_MATRIX_STACK_DEPTH                                                                                                                                                                                                                 = &H80B3&
Public Const GL_POST_COLOR_MATRIX_RED_SCALE                                                                                                                                                                                                              = &H80B4&
Public Const GL_POST_COLOR_MATRIX_GREEN_SCALE                                                                                                                                                                                                                = &H80B5&
Public Const GL_POST_COLOR_MATRIX_BLUE_SCALE                                                                                                                                                                                                                 = &H80B6&
Public Const GL_POST_COLOR_MATRIX_ALPHA_SCALE                                                                                                                                                                                                                = &H80B7&
Public Const GL_POST_COLOR_MATRIX_RED_BIAS                                                                                                                                                                                                               = &H80B8&
Public Const GL_POST_COLOR_MATRIX_GREEN_BIAS                                                                                                                                                                                                                 = &H80B9&
Public Const GL_POST_COLOR_MATRIX_BLUE_BIAS                                                                                                                                                                                                              = &H80BA&
Public Const GL_POST_COLOR_MATRIX_ALPHA_BIAS                                                                                                                                                                                                                 = &H80BB&
Public Const GL_COLOR_TABLE                                                                                                                                                                                                              = &H80D0&
Public Const GL_POST_CONVOLUTION_COLOR_TABLE                                                                                                                                                                                                                 = &H80D1&
Public Const GL_POST_COLOR_MATRIX_COLOR_TABLE                                                                                                                                                                                                                = &H80D2&
Public Const GL_PROXY_COLOR_TABLE                                                                                                                                                                                                                = &H80D3&
Public Const GL_PROXY_POST_CONVOLUTION_COLOR_TABLE                                                                                                                                                                                                               = &H80D4&
Public Const GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE                                                                                                                                                                                                              = &H80D5&
Public Const GL_COLOR_TABLE_SCALE                                                                                                                                                                                                                = &H80D6&
Public Const GL_COLOR_TABLE_BIAS                                                                                                                                                                                                                 = &H80D7&
Public Const GL_COLOR_TABLE_FORMAT                                                                                                                                                                                                               = &H80D8&
Public Const GL_COLOR_TABLE_WIDTH                                                                                                                                                                                                                = &H80D9&
Public Const GL_COLOR_TABLE_RED_SIZE                                                                                                                                                                                                                 = &H80DA&
Public Const GL_COLOR_TABLE_GREEN_SIZE                                                                                                                                                                                                               = &H80DB&
Public Const GL_COLOR_TABLE_BLUE_SIZE                                                                                                                                                                                                                = &H80DC&
Public Const GL_COLOR_TABLE_ALPHA_SIZE                                                                                                                                                                                                               = &H80DD&
Public Const GL_COLOR_TABLE_LUMINANCE_SIZE                                                                                                                                                                                                               = &H80DE&
Public Const GL_COLOR_TABLE_INTENSITY_SIZE                                                                                                                                                                                                               = &H80DF&
Public Const GL_IGNORE_BORDER                                                                                                                                                                                                                = &H8150&
Public Const GL_CONSTANT_BORDER                                                                                                                                                                                                              = &H8151&
Public Const GL_WRAP_BORDER                                                                                                                                                                                                              = &H8152&
Public Const GL_REPLICATE_BORDER                                                                                                                                                                                                                 = &H8153&
Public Const GL_CONVOLUTION_BORDER_COLOR                                                                                                                                                                                                                 = &H8154&
'------------------------------- GL_ARB_indirect_parameters -------------------------------
Public Const GL_PARAMETER_BUFFER_ARB                                                                                                                                                                                                                 = &H80EE&
Public Const GL_PARAMETER_BUFFER_BINDING_ARB                                                                                                                                                                                                                 = &H80EF&
'------------------------------- GL_ARB_instanced_arrays -------------------------------
Public Const GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB                                                                                                                                                                                                              = &H88FE&
'------------------------------- GL_ARB_internalformat_query -------------------------------
Public Const GL_NUM_SAMPLE_COUNTS                                                                                                                                                                                                                = &H9380&
'------------------------------- GL_ARB_internalformat_query2 -------------------------------
Public Const GL_INTERNALFORMAT_SUPPORTED                                                                                                                                                                                                                 = &H826F&
Public Const GL_INTERNALFORMAT_PREFERRED                                                                                                                                                                                                                 = &H8270&
Public Const GL_INTERNALFORMAT_RED_SIZE                                                                                                                                                                                                              = &H8271&
Public Const GL_INTERNALFORMAT_GREEN_SIZE                                                                                                                                                                                                                = &H8272&
Public Const GL_INTERNALFORMAT_BLUE_SIZE                                                                                                                                                                                                                 = &H8273&
Public Const GL_INTERNALFORMAT_ALPHA_SIZE                                                                                                                                                                                                                = &H8274&
Public Const GL_INTERNALFORMAT_DEPTH_SIZE                                                                                                                                                                                                                = &H8275&
Public Const GL_INTERNALFORMAT_STENCIL_SIZE                                                                                                                                                                                                              = &H8276&
Public Const GL_INTERNALFORMAT_SHARED_SIZE                                                                                                                                                                                                               = &H8277&
Public Const GL_INTERNALFORMAT_RED_TYPE                                                                                                                                                                                                              = &H8278&
Public Const GL_INTERNALFORMAT_GREEN_TYPE                                                                                                                                                                                                                = &H8279&
Public Const GL_INTERNALFORMAT_BLUE_TYPE                                                                                                                                                                                                                 = &H827A&
Public Const GL_INTERNALFORMAT_ALPHA_TYPE                                                                                                                                                                                                                = &H827B&
Public Const GL_INTERNALFORMAT_DEPTH_TYPE                                                                                                                                                                                                                = &H827C&
Public Const GL_INTERNALFORMAT_STENCIL_TYPE                                                                                                                                                                                                              = &H827D&
Public Const GL_MAX_WIDTH                                                                                                                                                                                                                = &H827E&
Public Const GL_MAX_HEIGHT                                                                                                                                                                                                               = &H827F&
Public Const GL_MAX_DEPTH                                                                                                                                                                                                                = &H8280&
Public Const GL_MAX_LAYERS                                                                                                                                                                                                               = &H8281&
Public Const GL_MAX_COMBINED_DIMENSIONS                                                                                                                                                                                                              = &H8282&
Public Const GL_COLOR_COMPONENTS                                                                                                                                                                                                                 = &H8283&
Public Const GL_DEPTH_COMPONENTS                                                                                                                                                                                                                 = &H8284&
Public Const GL_STENCIL_COMPONENTS                                                                                                                                                                                                               = &H8285&
Public Const GL_COLOR_RENDERABLE                                                                                                                                                                                                                 = &H8286&
Public Const GL_DEPTH_RENDERABLE                                                                                                                                                                                                                 = &H8287&
Public Const GL_STENCIL_RENDERABLE                                                                                                                                                                                                               = &H8288&
Public Const GL_FRAMEBUFFER_RENDERABLE                                                                                                                                                                                                               = &H8289&
Public Const GL_FRAMEBUFFER_RENDERABLE_LAYERED                                                                                                                                                                                                               = &H828A&
Public Const GL_FRAMEBUFFER_BLEND                                                                                                                                                                                                                = &H828B&
Public Const GL_READ_PIXELS                                                                                                                                                                                                              = &H828C&
Public Const GL_READ_PIXELS_FORMAT                                                                                                                                                                                                               = &H828D&
Public Const GL_READ_PIXELS_TYPE                                                                                                                                                                                                                 = &H828E&
Public Const GL_TEXTURE_IMAGE_FORMAT                                                                                                                                                                                                                 = &H828F&
Public Const GL_TEXTURE_IMAGE_TYPE                                                                                                                                                                                                               = &H8290&
Public Const GL_GET_TEXTURE_IMAGE_FORMAT                                                                                                                                                                                                                 = &H8291&
Public Const GL_GET_TEXTURE_IMAGE_TYPE                                                                                                                                                                                                               = &H8292&
Public Const GL_MIPMAP                                                                                                                                                                                                               = &H8293&
Public Const GL_MANUAL_GENERATE_MIPMAP                                                                                                                                                                                                               = &H8294&
Public Const GL_AUTO_GENERATE_MIPMAP                                                                                                                                                                                                                 = &H8295&
Public Const GL_COLOR_ENCODING                                                                                                                                                                                                               = &H8296&
Public Const GL_SRGB_READ                                                                                                                                                                                                                = &H8297&
Public Const GL_SRGB_WRITE                                                                                                                                                                                                               = &H8298&
Public Const GL_SRGB_DECODE_ARB                                                                                                                                                                                                              = &H8299&
Public Const GL_FILTER                                                                                                                                                                                                               = &H829A&
Public Const GL_VERTEX_TEXTURE                                                                                                                                                                                                               = &H829B&
Public Const GL_TESS_CONTROL_TEXTURE                                                                                                                                                                                                                 = &H829C&
Public Const GL_TESS_EVALUATION_TEXTURE                                                                                                                                                                                                              = &H829D&
Public Const GL_GEOMETRY_TEXTURE                                                                                                                                                                                                                 = &H829E&
Public Const GL_FRAGMENT_TEXTURE                                                                                                                                                                                                                 = &H829F&
Public Const GL_COMPUTE_TEXTURE                                                                                                                                                                                                              = &H82A0&
Public Const GL_TEXTURE_SHADOW                                                                                                                                                                                                               = &H82A1&
Public Const GL_TEXTURE_GATHER                                                                                                                                                                                                               = &H82A2&
Public Const GL_TEXTURE_GATHER_SHADOW                                                                                                                                                                                                                = &H82A3&
Public Const GL_SHADER_IMAGE_LOAD                                                                                                                                                                                                                = &H82A4&
Public Const GL_SHADER_IMAGE_STORE                                                                                                                                                                                                               = &H82A5&
Public Const GL_SHADER_IMAGE_ATOMIC                                                                                                                                                                                                              = &H82A6&
Public Const GL_IMAGE_TEXEL_SIZE                                                                                                                                                                                                                 = &H82A7&
Public Const GL_IMAGE_COMPATIBILITY_CLASS                                                                                                                                                                                                                = &H82A8&
Public Const GL_IMAGE_PIXEL_FORMAT                                                                                                                                                                                                               = &H82A9&
Public Const GL_IMAGE_PIXEL_TYPE                                                                                                                                                                                                                 = &H82AA&
Public Const GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST                                                                                                                                                                                                              = &H82AC&
Public Const GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST                                                                                                                                                                                                                = &H82AD&
Public Const GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE                                                                                                                                                                                                                 = &H82AE&
Public Const GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE                                                                                                                                                                                                               = &H82AF&
Public Const GL_TEXTURE_COMPRESSED_BLOCK_WIDTH                                                                                                                                                                                                               = &H82B1&
Public Const GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT                                                                                                                                                                                                              = &H82B2&
Public Const GL_TEXTURE_COMPRESSED_BLOCK_SIZE                                                                                                                                                                                                                = &H82B3&
Public Const GL_CLEAR_BUFFER                                                                                                                                                                                                                 = &H82B4&
Public Const GL_TEXTURE_VIEW                                                                                                                                                                                                                 = &H82B5&
Public Const GL_VIEW_COMPATIBILITY_CLASS                                                                                                                                                                                                                 = &H82B6&
Public Const GL_FULL_SUPPORT                                                                                                                                                                                                                 = &H82B7&
Public Const GL_CAVEAT_SUPPORT                                                                                                                                                                                                               = &H82B8&
Public Const GL_IMAGE_CLASS_4_X_32                                                                                                                                                                                                               = &H82B9&
Public Const GL_IMAGE_CLASS_2_X_32                                                                                                                                                                                                               = &H82BA&
Public Const GL_IMAGE_CLASS_1_X_32                                                                                                                                                                                                               = &H82BB&
Public Const GL_IMAGE_CLASS_4_X_16                                                                                                                                                                                                               = &H82BC&
Public Const GL_IMAGE_CLASS_2_X_16                                                                                                                                                                                                               = &H82BD&
Public Const GL_IMAGE_CLASS_1_X_16                                                                                                                                                                                                               = &H82BE&
Public Const GL_IMAGE_CLASS_4_X_8                                                                                                                                                                                                                = &H82BF&
Public Const GL_IMAGE_CLASS_2_X_8                                                                                                                                                                                                                = &H82C0&
Public Const GL_IMAGE_CLASS_1_X_8                                                                                                                                                                                                                = &H82C1&
Public Const GL_IMAGE_CLASS_11_11_10                                                                                                                                                                                                                 = &H82C2&
Public Const GL_IMAGE_CLASS_10_10_10_2                                                                                                                                                                                                               = &H82C3&
Public Const GL_VIEW_CLASS_128_BITS                                                                                                                                                                                                              = &H82C4&
Public Const GL_VIEW_CLASS_96_BITS                                                                                                                                                                                                               = &H82C5&
Public Const GL_VIEW_CLASS_64_BITS                                                                                                                                                                                                               = &H82C6&
Public Const GL_VIEW_CLASS_48_BITS                                                                                                                                                                                                               = &H82C7&
Public Const GL_VIEW_CLASS_32_BITS                                                                                                                                                                                                               = &H82C8&
Public Const GL_VIEW_CLASS_24_BITS                                                                                                                                                                                                               = &H82C9&
Public Const GL_VIEW_CLASS_16_BITS                                                                                                                                                                                                               = &H82CA&
Public Const GL_VIEW_CLASS_8_BITS                                                                                                                                                                                                                = &H82CB&
Public Const GL_VIEW_CLASS_S3TC_DXT1_RGB                                                                                                                                                                                                                 = &H82CC&
Public Const GL_VIEW_CLASS_S3TC_DXT1_RGBA                                                                                                                                                                                                                = &H82CD&
Public Const GL_VIEW_CLASS_S3TC_DXT3_RGBA                                                                                                                                                                                                                = &H82CE&
Public Const GL_VIEW_CLASS_S3TC_DXT5_RGBA                                                                                                                                                                                                                = &H82CF&
Public Const GL_VIEW_CLASS_RGTC1_RED                                                                                                                                                                                                                 = &H82D0&
Public Const GL_VIEW_CLASS_RGTC2_RG                                                                                                                                                                                                              = &H82D1&
Public Const GL_VIEW_CLASS_BPTC_UNORM                                                                                                                                                                                                                = &H82D2&
Public Const GL_VIEW_CLASS_BPTC_FLOAT                                                                                                                                                                                                                = &H82D3&
'------------------------------- GL_ARB_invalidate_subdata -------------------------------
'------------------------------- GL_ARB_map_buffer_alignment -------------------------------
Public Const GL_MIN_MAP_BUFFER_ALIGNMENT                                                                                                                                                                                                                 = &H90BC&
'------------------------------- GL_ARB_map_buffer_range -------------------------------
'public const GL_MAP_READ_BIT                                                                                                                                                                                                                = &h0001&
'public const GL_MAP_WRITE_BIT                                                                                                                                                                                                               = &h0002&
Public Const GL_MAP_INVALIDATE_RANGE_BIT                                                                                                                                                                                                                 = &H4&
Public Const GL_MAP_INVALIDATE_BUFFER_BIT                                                                                                                                                                                                                = &H8&
Public Const GL_MAP_FLUSH_EXPLICIT_BIT                                                                                                                                                                                                               = &H10&
Public Const GL_MAP_UNSYNCHRONIZED_BIT                                                                                                                                                                                                               = &H20&
'------------------------------- GL_ARB_matrix_palette -------------------------------
Public Const GL_MATRIX_PALETTE_ARB                                                                                                                                                                                                               = &H8840&
Public Const GL_MAX_MATRIX_PALETTE_STACK_DEPTH_ARB                                                                                                                                                                                                               = &H8841&
Public Const GL_MAX_PALETTE_MATRICES_ARB                                                                                                                                                                                                                 = &H8842&
Public Const GL_CURRENT_PALETTE_MATRIX_ARB                                                                                                                                                                                                               = &H8843&
Public Const GL_MATRIX_INDEX_ARRAY_ARB                                                                                                                                                                                                               = &H8844&
Public Const GL_CURRENT_MATRIX_INDEX_ARB                                                                                                                                                                                                                 = &H8845&
Public Const GL_MATRIX_INDEX_ARRAY_SIZE_ARB                                                                                                                                                                                                              = &H8846&
Public Const GL_MATRIX_INDEX_ARRAY_TYPE_ARB                                                                                                                                                                                                              = &H8847&
Public Const GL_MATRIX_INDEX_ARRAY_STRIDE_ARB                                                                                                                                                                                                                = &H8848&
Public Const GL_MATRIX_INDEX_ARRAY_POINTER_ARB                                                                                                                                                                                                               = &H8849&
'------------------------------- GL_ARB_multi_bind -------------------------------
'------------------------------- GL_ARB_multi_draw_indirect -------------------------------
'------------------------------- GL_ARB_multisample -------------------------------
Public Const GL_MULTISAMPLE_ARB                                                                                                                                                                                                              = &H809D&
Public Const GL_SAMPLE_ALPHA_TO_COVERAGE_ARB                                                                                                                                                                                                                 = &H809E&
Public Const GL_SAMPLE_ALPHA_TO_ONE_ARB                                                                                                                                                                                                              = &H809F&
Public Const GL_SAMPLE_COVERAGE_ARB                                                                                                                                                                                                              = &H80A0&
Public Const GL_SAMPLE_BUFFERS_ARB                                                                                                                                                                                                               = &H80A8&
Public Const GL_SAMPLES_ARB                                                                                                                                                                                                              = &H80A9&
Public Const GL_SAMPLE_COVERAGE_VALUE_ARB                                                                                                                                                                                                                = &H80AA&
Public Const GL_SAMPLE_COVERAGE_INVERT_ARB                                                                                                                                                                                                               = &H80AB&
Public Const GL_MULTISAMPLE_BIT_ARB                                                                                                                                                                                                              = &H20000000
'------------------------------- GL_ARB_multitexture -------------------------------
Public Const GL_TEXTURE0_ARB                                                                                                                                                                                                                 = &H84C0&
Public Const GL_TEXTURE1_ARB                                                                                                                                                                                                                 = &H84C1&
Public Const GL_TEXTURE2_ARB                                                                                                                                                                                                                 = &H84C2&
Public Const GL_TEXTURE3_ARB                                                                                                                                                                                                                 = &H84C3&
Public Const GL_TEXTURE4_ARB                                                                                                                                                                                                                 = &H84C4&
Public Const GL_TEXTURE5_ARB                                                                                                                                                                                                                 = &H84C5&
Public Const GL_TEXTURE6_ARB                                                                                                                                                                                                                 = &H84C6&
Public Const GL_TEXTURE7_ARB                                                                                                                                                                                                                 = &H84C7&
Public Const GL_TEXTURE8_ARB                                                                                                                                                                                                                 = &H84C8&
Public Const GL_TEXTURE9_ARB                                                                                                                                                                                                                 = &H84C9&
Public Const GL_TEXTURE10_ARB                                                                                                                                                                                                                = &H84CA&
Public Const GL_TEXTURE11_ARB                                                                                                                                                                                                                = &H84CB&
Public Const GL_TEXTURE12_ARB                                                                                                                                                                                                                = &H84CC&
Public Const GL_TEXTURE13_ARB                                                                                                                                                                                                                = &H84CD&
Public Const GL_TEXTURE14_ARB                                                                                                                                                                                                                = &H84CE&
Public Const GL_TEXTURE15_ARB                                                                                                                                                                                                                = &H84CF&
Public Const GL_TEXTURE16_ARB                                                                                                                                                                                                                = &H84D0&
Public Const GL_TEXTURE17_ARB                                                                                                                                                                                                                = &H84D1&
Public Const GL_TEXTURE18_ARB                                                                                                                                                                                                                = &H84D2&
Public Const GL_TEXTURE19_ARB                                                                                                                                                                                                                = &H84D3&
Public Const GL_TEXTURE20_ARB                                                                                                                                                                                                                = &H84D4&
Public Const GL_TEXTURE21_ARB                                                                                                                                                                                                                = &H84D5&
Public Const GL_TEXTURE22_ARB                                                                                                                                                                                                                = &H84D6&
Public Const GL_TEXTURE23_ARB                                                                                                                                                                                                                = &H84D7&
Public Const GL_TEXTURE24_ARB                                                                                                                                                                                                                = &H84D8&
Public Const GL_TEXTURE25_ARB                                                                                                                                                                                                                = &H84D9&
Public Const GL_TEXTURE26_ARB                                                                                                                                                                                                                = &H84DA&
Public Const GL_TEXTURE27_ARB                                                                                                                                                                                                                = &H84DB&
Public Const GL_TEXTURE28_ARB                                                                                                                                                                                                                = &H84DC&
Public Const GL_TEXTURE29_ARB                                                                                                                                                                                                                = &H84DD&
Public Const GL_TEXTURE30_ARB                                                                                                                                                                                                                = &H84DE&
Public Const GL_TEXTURE31_ARB                                                                                                                                                                                                                = &H84DF&
Public Const GL_ACTIVE_TEXTURE_ARB                                                                                                                                                                                                               = &H84E0&
Public Const GL_CLIENT_ACTIVE_TEXTURE_ARB                                                                                                                                                                                                                = &H84E1&
Public Const GL_MAX_TEXTURE_UNITS_ARB                                                                                                                                                                                                                = &H84E2&
'------------------------------- GL_ARB_occlusion_query -------------------------------
Public Const GL_QUERY_COUNTER_BITS_ARB                                                                                                                                                                                                               = &H8864&
Public Const GL_CURRENT_QUERY_ARB                                                                                                                                                                                                                = &H8865&
Public Const GL_QUERY_RESULT_ARB                                                                                                                                                                                                                 = &H8866&
Public Const GL_QUERY_RESULT_AVAILABLE_ARB                                                                                                                                                                                                               = &H8867&
Public Const GL_SAMPLES_PASSED_ARB                                                                                                                                                                                                               = &H8914&
'------------------------------- GL_ARB_occlusion_query2 -------------------------------
Public Const GL_ANY_SAMPLES_PASSED                                                                                                                                                                                                               = &H8C2F&
'------------------------------- GL_ARB_parallel_shader_compile -------------------------------
Public Const GL_MAX_SHADER_COMPILER_THREADS_ARB                                                                                                                                                                                                              = &H91B0&
Public Const GL_COMPLETION_STATUS_ARB                                                                                                                                                                                                                = &H91B1&
'------------------------------- GL_ARB_pipeline_statistics_query -------------------------------
Public Const GL_VERTICES_SUBMITTED_ARB                                                                                                                                                                                                               = &H82EE&
Public Const GL_PRIMITIVES_SUBMITTED_ARB                                                                                                                                                                                                                 = &H82EF&
Public Const GL_VERTEX_SHADER_INVOCATIONS_ARB                                                                                                                                                                                                                = &H82F0&
Public Const GL_TESS_CONTROL_SHADER_PATCHES_ARB                                                                                                                                                                                                              = &H82F1&
Public Const GL_TESS_EVALUATION_SHADER_INVOCATIONS_ARB                                                                                                                                                                                                               = &H82F2&
Public Const GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED_ARB                                                                                                                                                                                                               = &H82F3&
Public Const GL_FRAGMENT_SHADER_INVOCATIONS_ARB                                                                                                                                                                                                              = &H82F4&
Public Const GL_COMPUTE_SHADER_INVOCATIONS_ARB                                                                                                                                                                                                               = &H82F5&
Public Const GL_CLIPPING_INPUT_PRIMITIVES_ARB                                                                                                                                                                                                                = &H82F6&
Public Const GL_CLIPPING_OUTPUT_PRIMITIVES_ARB                                                                                                                                                                                                               = &H82F7&
'public const GL_GEOMETRY_SHADER_INVOCATIONS                                                                                                                                                                                                                 = &h887F&
'------------------------------- GL_ARB_pixel_buffer_object -------------------------------
Public Const GL_PIXEL_PACK_BUFFER_ARB                                                                                                                                                                                                                = &H88EB&
Public Const GL_PIXEL_UNPACK_BUFFER_ARB                                                                                                                                                                                                              = &H88EC&
Public Const GL_PIXEL_PACK_BUFFER_BINDING_ARB                                                                                                                                                                                                                = &H88ED&
Public Const GL_PIXEL_UNPACK_BUFFER_BINDING_ARB                                                                                                                                                                                                              = &H88EF&
'------------------------------- GL_ARB_point_parameters -------------------------------
Public Const GL_POINT_SIZE_MIN_ARB                                                                                                                                                                                                               = &H8126&
Public Const GL_POINT_SIZE_MAX_ARB                                                                                                                                                                                                               = &H8127&
Public Const GL_POINT_FADE_THRESHOLD_SIZE_ARB                                                                                                                                                                                                                = &H8128&
Public Const GL_POINT_DISTANCE_ATTENUATION_ARB                                                                                                                                                                                                               = &H8129&
'------------------------------- GL_ARB_point_sprite -------------------------------
Public Const GL_POINT_SPRITE_ARB                                                                                                                                                                                                                 = &H8861&
Public Const GL_COORD_REPLACE_ARB                                                                                                                                                                                                                = &H8862&
'------------------------------- GL_ARB_polygon_offset_clamp -------------------------------
'public const GL_POLYGON_OFFSET_CLAMP                                                                                                                                                                                                                = &h8E1B&
'------------------------------- GL_ARB_post_depth_coverage -------------------------------
'------------------------------- GL_ARB_program_interface_query -------------------------------
Public Const GL_UNIFORM                                                                                                                                                                                                              = &H92E1&
Public Const GL_UNIFORM_BLOCK                                                                                                                                                                                                                = &H92E2&
Public Const GL_PROGRAM_INPUT                                                                                                                                                                                                                = &H92E3&
Public Const GL_PROGRAM_OUTPUT                                                                                                                                                                                                               = &H92E4&
Public Const GL_BUFFER_VARIABLE                                                                                                                                                                                                              = &H92E5&
Public Const GL_SHADER_STORAGE_BLOCK                                                                                                                                                                                                                 = &H92E6&
Public Const GL_IS_PER_PATCH                                                                                                                                                                                                                 = &H92E7&
Public Const GL_VERTEX_SUBROUTINE                                                                                                                                                                                                                = &H92E8&
Public Const GL_TESS_CONTROL_SUBROUTINE                                                                                                                                                                                                              = &H92E9&
Public Const GL_TESS_EVALUATION_SUBROUTINE                                                                                                                                                                                                               = &H92EA&
Public Const GL_GEOMETRY_SUBROUTINE                                                                                                                                                                                                              = &H92EB&
Public Const GL_FRAGMENT_SUBROUTINE                                                                                                                                                                                                              = &H92EC&
Public Const GL_COMPUTE_SUBROUTINE                                                                                                                                                                                                               = &H92ED&
Public Const GL_VERTEX_SUBROUTINE_UNIFORM                                                                                                                                                                                                                = &H92EE&
Public Const GL_TESS_CONTROL_SUBROUTINE_UNIFORM                                                                                                                                                                                                              = &H92EF&
Public Const GL_TESS_EVALUATION_SUBROUTINE_UNIFORM                                                                                                                                                                                                               = &H92F0&
Public Const GL_GEOMETRY_SUBROUTINE_UNIFORM                                                                                                                                                                                                              = &H92F1&
Public Const GL_FRAGMENT_SUBROUTINE_UNIFORM                                                                                                                                                                                                              = &H92F2&
Public Const GL_COMPUTE_SUBROUTINE_UNIFORM                                                                                                                                                                                                               = &H92F3&
Public Const GL_TRANSFORM_FEEDBACK_VARYING                                                                                                                                                                                                               = &H92F4&
Public Const GL_ACTIVE_RESOURCES                                                                                                                                                                                                                 = &H92F5&
Public Const GL_MAX_NAME_LENGTH                                                                                                                                                                                                              = &H92F6&
Public Const GL_MAX_NUM_ACTIVE_VARIABLES                                                                                                                                                                                                                 = &H92F7&
Public Const GL_MAX_NUM_COMPATIBLE_SUBROUTINES                                                                                                                                                                                                               = &H92F8&
Public Const GL_NAME_LENGTH                                                                                                                                                                                                              = &H92F9&
Public Const GL_TYPE                                                                                                                                                                                                                 = &H92FA&
Public Const GL_ARRAY_SIZE                                                                                                                                                                                                               = &H92FB&
Public Const GL_OFFSET                                                                                                                                                                                                               = &H92FC&
Public Const GL_BLOCK_INDEX                                                                                                                                                                                                              = &H92FD&
Public Const GL_ARRAY_STRIDE                                                                                                                                                                                                                 = &H92FE&
Public Const GL_MATRIX_STRIDE                                                                                                                                                                                                                = &H92FF&
Public Const GL_IS_ROW_MAJOR                                                                                                                                                                                                                 = &H9300&
Public Const GL_ATOMIC_COUNTER_BUFFER_INDEX                                                                                                                                                                                                              = &H9301&
Public Const GL_BUFFER_BINDING                                                                                                                                                                                                               = &H9302&
Public Const GL_BUFFER_DATA_SIZE                                                                                                                                                                                                                 = &H9303&
Public Const GL_NUM_ACTIVE_VARIABLES                                                                                                                                                                                                                 = &H9304&
Public Const GL_ACTIVE_VARIABLES                                                                                                                                                                                                                 = &H9305&
Public Const GL_REFERENCED_BY_VERTEX_SHADER                                                                                                                                                                                                              = &H9306&
Public Const GL_REFERENCED_BY_TESS_CONTROL_SHADER                                                                                                                                                                                                                = &H9307&
Public Const GL_REFERENCED_BY_TESS_EVALUATION_SHADER                                                                                                                                                                                                                 = &H9308&
Public Const GL_REFERENCED_BY_GEOMETRY_SHADER                                                                                                                                                                                                                = &H9309&
Public Const GL_REFERENCED_BY_FRAGMENT_SHADER                                                                                                                                                                                                                = &H930A&
Public Const GL_REFERENCED_BY_COMPUTE_SHADER                                                                                                                                                                                                                 = &H930B&
Public Const GL_TOP_LEVEL_ARRAY_SIZE                                                                                                                                                                                                                 = &H930C&
Public Const GL_TOP_LEVEL_ARRAY_STRIDE                                                                                                                                                                                                               = &H930D&
Public Const GL_LOCATION                                                                                                                                                                                                                 = &H930E&
Public Const GL_LOCATION_INDEX                                                                                                                                                                                                               = &H930F&
'------------------------------- GL_ARB_provoking_vertex -------------------------------
Public Const GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION                                                                                                                                                                                                                 = &H8E4C&
Public Const GL_FIRST_VERTEX_CONVENTION                                                                                                                                                                                                              = &H8E4D&
Public Const GL_LAST_VERTEX_CONVENTION                                                                                                                                                                                                               = &H8E4E&
Public Const GL_PROVOKING_VERTEX                                                                                                                                                                                                                 = &H8E4F&
'------------------------------- GL_ARB_query_buffer_object -------------------------------
Public Const GL_QUERY_BUFFER_BARRIER_BIT                                                                                                                                                                                                                 = &H8000&
Public Const GL_QUERY_BUFFER                                                                                                                                                                                                                 = &H9192&
Public Const GL_QUERY_BUFFER_BINDING                                                                                                                                                                                                                 = &H9193&
Public Const GL_QUERY_RESULT_NO_WAIT                                                                                                                                                                                                                 = &H9194&
'------------------------------- GL_ARB_robust_buffer_access_behavior -------------------------------
'------------------------------- GL_ARB_robustness -------------------------------
Public Const GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB                                                                                                                                                                                                               = &H4&
Public Const GL_LOSE_CONTEXT_ON_RESET_ARB                                                                                                                                                                                                                = &H8252&
Public Const GL_GUILTY_CONTEXT_RESET_ARB                                                                                                                                                                                                                 = &H8253&
Public Const GL_INNOCENT_CONTEXT_RESET_ARB                                                                                                                                                                                                               = &H8254&
Public Const GL_UNKNOWN_CONTEXT_RESET_ARB                                                                                                                                                                                                                = &H8255&
Public Const GL_RESET_NOTIFICATION_STRATEGY_ARB                                                                                                                                                                                                              = &H8256&
Public Const GL_NO_RESET_NOTIFICATION_ARB                                                                                                                                                                                                                = &H8261&
'------------------------------- GL_ARB_robustness_application_isolation -------------------------------
'------------------------------- GL_ARB_robustness_share_group_isolation -------------------------------
'------------------------------- GL_ARB_sample_locations -------------------------------
Public Const GL_SAMPLE_LOCATION_ARB                                                                                                                                                                                                              = &H8E50&
Public Const GL_SAMPLE_LOCATION_SUBPIXEL_BITS_ARB                                                                                                                                                                                                                = &H933D&
Public Const GL_SAMPLE_LOCATION_PIXEL_GRID_WIDTH_ARB                                                                                                                                                                                                                 = &H933E&
Public Const GL_SAMPLE_LOCATION_PIXEL_GRID_HEIGHT_ARB                                                                                                                                                                                                                = &H933F&
Public Const GL_PROGRAMMABLE_SAMPLE_LOCATION_TABLE_SIZE_ARB                                                                                                                                                                                                              = &H9340&
Public Const GL_PROGRAMMABLE_SAMPLE_LOCATION_ARB                                                                                                                                                                                                                 = &H9341&
Public Const GL_FRAMEBUFFER_PROGRAMMABLE_SAMPLE_LOCATIONS_ARB                                                                                                                                                                                                                = &H9342&
Public Const GL_FRAMEBUFFER_SAMPLE_LOCATION_PIXEL_GRID_ARB                                                                                                                                                                                                               = &H9343&
'------------------------------- GL_ARB_sample_shading -------------------------------
Public Const GL_SAMPLE_SHADING_ARB                                                                                                                                                                                                               = &H8C36&
Public Const GL_MIN_SAMPLE_SHADING_VALUE_ARB                                                                                                                                                                                                                 = &H8C37&
'------------------------------- GL_ARB_sampler_objects -------------------------------
Public Const GL_SAMPLER_BINDING                                                                                                                                                                                                              = &H8919&
'------------------------------- GL_ARB_seamless_cube_map -------------------------------
Public Const GL_TEXTURE_CUBE_MAP_SEAMLESS                                                                                                                                                                                                                = &H884F&
'------------------------------- GL_ARB_seamless_cubemap_per_texture -------------------------------
'public const GL_TEXTURE_CUBE_MAP_SEAMLESS                                                                                                                                                                                                               = &h884F&
'------------------------------- GL_ARB_separate_shader_objects -------------------------------
Public Const GL_VERTEX_SHADER_BIT                                                                                                                                                                                                                = &H1&
Public Const GL_FRAGMENT_SHADER_BIT                                                                                                                                                                                                              = &H2&
Public Const GL_GEOMETRY_SHADER_BIT                                                                                                                                                                                                              = &H4&
Public Const GL_TESS_CONTROL_SHADER_BIT                                                                                                                                                                                                              = &H8&
Public Const GL_TESS_EVALUATION_SHADER_BIT                                                                                                                                                                                                               = &H10&
Public Const GL_PROGRAM_SEPARABLE                                                                                                                                                                                                                = &H8258&
Public Const GL_ACTIVE_PROGRAM                                                                                                                                                                                                               = &H8259&
Public Const GL_PROGRAM_PIPELINE_BINDING                                                                                                                                                                                                                 = &H825A&
Public Const GL_ALL_SHADER_BITS                                                                                                                                                                                                              = &HFFFFFFFF
'------------------------------- GL_ARB_shader_atomic_counter_ops -------------------------------
'------------------------------- GL_ARB_shader_atomic_counters -------------------------------
Public Const GL_ATOMIC_COUNTER_BUFFER                                                                                                                                                                                                                = &H92C0&
Public Const GL_ATOMIC_COUNTER_BUFFER_BINDING                                                                                                                                                                                                                = &H92C1&
Public Const GL_ATOMIC_COUNTER_BUFFER_START                                                                                                                                                                                                              = &H92C2&
Public Const GL_ATOMIC_COUNTER_BUFFER_SIZE                                                                                                                                                                                                               = &H92C3&
Public Const GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE                                                                                                                                                                                                              = &H92C4&
Public Const GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS                                                                                                                                                                                                                 = &H92C5&
Public Const GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES                                                                                                                                                                                                              = &H92C6&
Public Const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER                                                                                                                                                                                                                = &H92C7&
Public Const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER                                                                                                                                                                                                              = &H92C8&
Public Const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER                                                                                                                                                                                                               = &H92C9&
Public Const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER                                                                                                                                                                                                              = &H92CA&
Public Const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER                                                                                                                                                                                                              = &H92CB&
Public Const GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS                                                                                                                                                                                                                = &H92CC&
Public Const GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS                                                                                                                                                                                                              = &H92CD&
Public Const GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS                                                                                                                                                                                                               = &H92CE&
Public Const GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS                                                                                                                                                                                                              = &H92CF&
Public Const GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS                                                                                                                                                                                                              = &H92D0&
Public Const GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS                                                                                                                                                                                                              = &H92D1&
Public Const GL_MAX_VERTEX_ATOMIC_COUNTERS                                                                                                                                                                                                               = &H92D2&
Public Const GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS                                                                                                                                                                                                                 = &H92D3&
Public Const GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS                                                                                                                                                                                                              = &H92D4&
Public Const GL_MAX_GEOMETRY_ATOMIC_COUNTERS                                                                                                                                                                                                                 = &H92D5&
Public Const GL_MAX_FRAGMENT_ATOMIC_COUNTERS                                                                                                                                                                                                                 = &H92D6&
Public Const GL_MAX_COMBINED_ATOMIC_COUNTERS                                                                                                                                                                                                                 = &H92D7&
Public Const GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE                                                                                                                                                                                                               = &H92D8&
Public Const GL_ACTIVE_ATOMIC_COUNTER_BUFFERS                                                                                                                                                                                                                = &H92D9&
Public Const GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX                                                                                                                                                                                                              = &H92DA&
Public Const GL_UNSIGNED_INT_ATOMIC_COUNTER                                                                                                                                                                                                              = &H92DB&
Public Const GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS                                                                                                                                                                                                               = &H92DC&
'------------------------------- GL_ARB_shader_ballot -------------------------------
'------------------------------- GL_ARB_shader_bit_encoding -------------------------------
'------------------------------- GL_ARB_shader_clock -------------------------------
'------------------------------- GL_ARB_shader_draw_parameters -------------------------------
'------------------------------- GL_ARB_shader_group_vote -------------------------------
'------------------------------- GL_ARB_shader_image_load_store -------------------------------
Public Const GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT                                                                                                                                                                                                              = &H1&
Public Const GL_ELEMENT_ARRAY_BARRIER_BIT                                                                                                                                                                                                                = &H2&
Public Const GL_UNIFORM_BARRIER_BIT                                                                                                                                                                                                              = &H4&
Public Const GL_TEXTURE_FETCH_BARRIER_BIT                                                                                                                                                                                                                = &H8&
Public Const GL_SHADER_IMAGE_ACCESS_BARRIER_BIT                                                                                                                                                                                                              = &H20&
Public Const GL_COMMAND_BARRIER_BIT                                                                                                                                                                                                              = &H40&
Public Const GL_PIXEL_BUFFER_BARRIER_BIT                                                                                                                                                                                                                 = &H80&
Public Const GL_TEXTURE_UPDATE_BARRIER_BIT                                                                                                                                                                                                               = &H100&
Public Const GL_BUFFER_UPDATE_BARRIER_BIT                                                                                                                                                                                                                = &H200&
Public Const GL_FRAMEBUFFER_BARRIER_BIT                                                                                                                                                                                                              = &H400&
Public Const GL_TRANSFORM_FEEDBACK_BARRIER_BIT                                                                                                                                                                                                               = &H800&
Public Const GL_ATOMIC_COUNTER_BARRIER_BIT                                                                                                                                                                                                               = &H1000&
Public Const GL_MAX_IMAGE_UNITS                                                                                                                                                                                                              = &H8F38&
Public Const GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS                                                                                                                                                                                                                = &H8F39&
Public Const GL_IMAGE_BINDING_NAME                                                                                                                                                                                                               = &H8F3A&
Public Const GL_IMAGE_BINDING_LEVEL                                                                                                                                                                                                              = &H8F3B&
Public Const GL_IMAGE_BINDING_LAYERED                                                                                                                                                                                                                = &H8F3C&
Public Const GL_IMAGE_BINDING_LAYER                                                                                                                                                                                                              = &H8F3D&
Public Const GL_IMAGE_BINDING_ACCESS                                                                                                                                                                                                                 = &H8F3E&
Public Const GL_IMAGE_1D                                                                                                                                                                                                                 = &H904C&
Public Const GL_IMAGE_2D                                                                                                                                                                                                                 = &H904D&
Public Const GL_IMAGE_3D                                                                                                                                                                                                                 = &H904E&
Public Const GL_IMAGE_2D_RECT                                                                                                                                                                                                                = &H904F&
Public Const GL_IMAGE_CUBE                                                                                                                                                                                                               = &H9050&
Public Const GL_IMAGE_BUFFER                                                                                                                                                                                                                 = &H9051&
Public Const GL_IMAGE_1D_ARRAY                                                                                                                                                                                                               = &H9052&
Public Const GL_IMAGE_2D_ARRAY                                                                                                                                                                                                               = &H9053&
Public Const GL_IMAGE_CUBE_MAP_ARRAY                                                                                                                                                                                                                 = &H9054&
Public Const GL_IMAGE_2D_MULTISAMPLE                                                                                                                                                                                                                 = &H9055&
Public Const GL_IMAGE_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                               = &H9056&
Public Const GL_INT_IMAGE_1D                                                                                                                                                                                                                 = &H9057&
Public Const GL_INT_IMAGE_2D                                                                                                                                                                                                                 = &H9058&
Public Const GL_INT_IMAGE_3D                                                                                                                                                                                                                 = &H9059&
Public Const GL_INT_IMAGE_2D_RECT                                                                                                                                                                                                                = &H905A&
Public Const GL_INT_IMAGE_CUBE                                                                                                                                                                                                               = &H905B&
Public Const GL_INT_IMAGE_BUFFER                                                                                                                                                                                                                 = &H905C&
Public Const GL_INT_IMAGE_1D_ARRAY                                                                                                                                                                                                               = &H905D&
Public Const GL_INT_IMAGE_2D_ARRAY                                                                                                                                                                                                               = &H905E&
Public Const GL_INT_IMAGE_CUBE_MAP_ARRAY                                                                                                                                                                                                                 = &H905F&
Public Const GL_INT_IMAGE_2D_MULTISAMPLE                                                                                                                                                                                                                 = &H9060&
Public Const GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                               = &H9061&
Public Const GL_UNSIGNED_INT_IMAGE_1D                                                                                                                                                                                                                = &H9062&
Public Const GL_UNSIGNED_INT_IMAGE_2D                                                                                                                                                                                                                = &H9063&
Public Const GL_UNSIGNED_INT_IMAGE_3D                                                                                                                                                                                                                = &H9064&
Public Const GL_UNSIGNED_INT_IMAGE_2D_RECT                                                                                                                                                                                                               = &H9065&
Public Const GL_UNSIGNED_INT_IMAGE_CUBE                                                                                                                                                                                                              = &H9066&
Public Const GL_UNSIGNED_INT_IMAGE_BUFFER                                                                                                                                                                                                                = &H9067&
Public Const GL_UNSIGNED_INT_IMAGE_1D_ARRAY                                                                                                                                                                                                              = &H9068&
Public Const GL_UNSIGNED_INT_IMAGE_2D_ARRAY                                                                                                                                                                                                              = &H9069&
Public Const GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY                                                                                                                                                                                                                = &H906A&
Public Const GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE                                                                                                                                                                                                                = &H906B&
Public Const GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                              = &H906C&
Public Const GL_MAX_IMAGE_SAMPLES                                                                                                                                                                                                                = &H906D&
Public Const GL_IMAGE_BINDING_FORMAT                                                                                                                                                                                                                 = &H906E&
Public Const GL_IMAGE_FORMAT_COMPATIBILITY_TYPE                                                                                                                                                                                                              = &H90C7&
Public Const GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE                                                                                                                                                                                                               = &H90C8&
Public Const GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS                                                                                                                                                                                                              = &H90C9&
Public Const GL_MAX_VERTEX_IMAGE_UNIFORMS                                                                                                                                                                                                                = &H90CA&
Public Const GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS                                                                                                                                                                                                              = &H90CB&
Public Const GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS                                                                                                                                                                                                               = &H90CC&
Public Const GL_MAX_GEOMETRY_IMAGE_UNIFORMS                                                                                                                                                                                                              = &H90CD&
Public Const GL_MAX_FRAGMENT_IMAGE_UNIFORMS                                                                                                                                                                                                              = &H90CE&
Public Const GL_MAX_COMBINED_IMAGE_UNIFORMS                                                                                                                                                                                                              = &H90CF&
Public Const GL_ALL_BARRIER_BITS                                                                                                                                                                                                                 = &HFFFFFFFF
'------------------------------- GL_ARB_shader_image_size -------------------------------
'------------------------------- GL_ARB_shader_objects -------------------------------
Public Const GL_PROGRAM_OBJECT_ARB                                                                                                                                                                                                               = &H8B40&
Public Const GL_SHADER_OBJECT_ARB                                                                                                                                                                                                                = &H8B48&
Public Const GL_OBJECT_TYPE_ARB                                                                                                                                                                                                              = &H8B4E&
Public Const GL_OBJECT_SUBTYPE_ARB                                                                                                                                                                                                               = &H8B4F&
Public Const GL_FLOAT_VEC2_ARB                                                                                                                                                                                                               = &H8B50&
Public Const GL_FLOAT_VEC3_ARB                                                                                                                                                                                                               = &H8B51&
Public Const GL_FLOAT_VEC4_ARB                                                                                                                                                                                                               = &H8B52&
Public Const GL_INT_VEC2_ARB                                                                                                                                                                                                                 = &H8B53&
Public Const GL_INT_VEC3_ARB                                                                                                                                                                                                                 = &H8B54&
Public Const GL_INT_VEC4_ARB                                                                                                                                                                                                                 = &H8B55&
Public Const GL_BOOL_ARB                                                                                                                                                                                                                 = &H8B56&
Public Const GL_BOOL_VEC2_ARB                                                                                                                                                                                                                = &H8B57&
Public Const GL_BOOL_VEC3_ARB                                                                                                                                                                                                                = &H8B58&
Public Const GL_BOOL_VEC4_ARB                                                                                                                                                                                                                = &H8B59&
Public Const GL_FLOAT_MAT2_ARB                                                                                                                                                                                                               = &H8B5A&
Public Const GL_FLOAT_MAT3_ARB                                                                                                                                                                                                               = &H8B5B&
Public Const GL_FLOAT_MAT4_ARB                                                                                                                                                                                                               = &H8B5C&
Public Const GL_SAMPLER_1D_ARB                                                                                                                                                                                                               = &H8B5D&
Public Const GL_SAMPLER_2D_ARB                                                                                                                                                                                                               = &H8B5E&
Public Const GL_SAMPLER_3D_ARB                                                                                                                                                                                                               = &H8B5F&
Public Const GL_SAMPLER_CUBE_ARB                                                                                                                                                                                                                 = &H8B60&
Public Const GL_SAMPLER_1D_SHADOW_ARB                                                                                                                                                                                                                = &H8B61&
Public Const GL_SAMPLER_2D_SHADOW_ARB                                                                                                                                                                                                                = &H8B62&
Public Const GL_SAMPLER_2D_RECT_ARB                                                                                                                                                                                                              = &H8B63&
Public Const GL_SAMPLER_2D_RECT_SHADOW_ARB                                                                                                                                                                                                               = &H8B64&
Public Const GL_OBJECT_DELETE_STATUS_ARB                                                                                                                                                                                                                 = &H8B80&
Public Const GL_OBJECT_COMPILE_STATUS_ARB                                                                                                                                                                                                                = &H8B81&
Public Const GL_OBJECT_LINK_STATUS_ARB                                                                                                                                                                                                               = &H8B82&
Public Const GL_OBJECT_VALIDATE_STATUS_ARB                                                                                                                                                                                                               = &H8B83&
Public Const GL_OBJECT_INFO_LOG_LENGTH_ARB                                                                                                                                                                                                               = &H8B84&
Public Const GL_OBJECT_ATTACHED_OBJECTS_ARB                                                                                                                                                                                                              = &H8B85&
Public Const GL_OBJECT_ACTIVE_UNIFORMS_ARB                                                                                                                                                                                                               = &H8B86&
Public Const GL_OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB                                                                                                                                                                                                                 = &H8B87&
Public Const GL_OBJECT_SHADER_SOURCE_LENGTH_ARB                                                                                                                                                                                                              = &H8B88&
'------------------------------- GL_ARB_shader_precision -------------------------------
'------------------------------- GL_ARB_shader_stencil_export -------------------------------
'------------------------------- GL_ARB_shader_storage_buffer_object -------------------------------
Public Const GL_SHADER_STORAGE_BARRIER_BIT                                                                                                                                                                                                               = &H2000&
Public Const GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES                                                                                                                                                                                                                 = &H8F39&
Public Const GL_SHADER_STORAGE_BUFFER                                                                                                                                                                                                                = &H90D2&
Public Const GL_SHADER_STORAGE_BUFFER_BINDING                                                                                                                                                                                                                = &H90D3&
Public Const GL_SHADER_STORAGE_BUFFER_START                                                                                                                                                                                                              = &H90D4&
Public Const GL_SHADER_STORAGE_BUFFER_SIZE                                                                                                                                                                                                               = &H90D5&
Public Const GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS                                                                                                                                                                                                                 = &H90D6&
Public Const GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS                                                                                                                                                                                                               = &H90D7&
Public Const GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS                                                                                                                                                                                                               = &H90D8&
Public Const GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS                                                                                                                                                                                                                = &H90D9&
Public Const GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS                                                                                                                                                                                                               = &H90DA&
Public Const GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS                                                                                                                                                                                                                = &H90DB&
Public Const GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS                                                                                                                                                                                                               = &H90DC&
Public Const GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS                                                                                                                                                                                                               = &H90DD&
Public Const GL_MAX_SHADER_STORAGE_BLOCK_SIZE                                                                                                                                                                                                                = &H90DE&
Public Const GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT                                                                                                                                                                                                               = &H90DF&
'------------------------------- GL_ARB_shader_subroutine -------------------------------
Public Const GL_ACTIVE_SUBROUTINES                                                                                                                                                                                                               = &H8DE5&
Public Const GL_ACTIVE_SUBROUTINE_UNIFORMS                                                                                                                                                                                                               = &H8DE6&
Public Const GL_MAX_SUBROUTINES                                                                                                                                                                                                              = &H8DE7&
Public Const GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS                                                                                                                                                                                                                 = &H8DE8&
Public Const GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS                                                                                                                                                                                                              = &H8E47&
Public Const GL_ACTIVE_SUBROUTINE_MAX_LENGTH                                                                                                                                                                                                                 = &H8E48&
Public Const GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH                                                                                                                                                                                                                 = &H8E49&
Public Const GL_NUM_COMPATIBLE_SUBROUTINES                                                                                                                                                                                                               = &H8E4A&
Public Const GL_COMPATIBLE_SUBROUTINES                                                                                                                                                                                                               = &H8E4B&
'------------------------------- GL_ARB_shader_texture_image_samples -------------------------------
'------------------------------- GL_ARB_shader_texture_lod -------------------------------
'------------------------------- GL_ARB_shader_viewport_layer_array -------------------------------
'------------------------------- GL_ARB_shading_language_100 -------------------------------
Public Const GL_SHADING_LANGUAGE_VERSION_ARB                                                                                                                                                                                                                 = &H8B8C&
'------------------------------- GL_ARB_shading_language_420pack -------------------------------
'------------------------------- GL_ARB_shading_language_include -------------------------------
Public Const GL_SHADER_INCLUDE_ARB                                                                                                                                                                                                               = &H8DAE&
Public Const GL_NAMED_STRING_LENGTH_ARB                                                                                                                                                                                                              = &H8DE9&
Public Const GL_NAMED_STRING_TYPE_ARB                                                                                                                                                                                                                = &H8DEA&
'------------------------------- GL_ARB_shading_language_packing -------------------------------
'------------------------------- GL_ARB_shadow -------------------------------
Public Const GL_TEXTURE_COMPARE_MODE_ARB                                                                                                                                                                                                                 = &H884C&
Public Const GL_TEXTURE_COMPARE_FUNC_ARB                                                                                                                                                                                                                 = &H884D&
Public Const GL_COMPARE_R_TO_TEXTURE_ARB                                                                                                                                                                                                                 = &H884E&
'------------------------------- GL_ARB_shadow_ambient -------------------------------
Public Const GL_TEXTURE_COMPARE_FAIL_VALUE_ARB                                                                                                                                                                                                               = &H80BF&
'------------------------------- GL_ARB_sparse_buffer -------------------------------
Public Const GL_SPARSE_STORAGE_BIT_ARB                                                                                                                                                                                                               = &H400&
Public Const GL_SPARSE_BUFFER_PAGE_SIZE_ARB                                                                                                                                                                                                              = &H82F8&
'------------------------------- GL_ARB_sparse_texture -------------------------------
Public Const GL_VIRTUAL_PAGE_SIZE_X_ARB                                                                                                                                                                                                              = &H9195&
Public Const GL_VIRTUAL_PAGE_SIZE_Y_ARB                                                                                                                                                                                                              = &H9196&
Public Const GL_VIRTUAL_PAGE_SIZE_Z_ARB                                                                                                                                                                                                              = &H9197&
Public Const GL_MAX_SPARSE_TEXTURE_SIZE_ARB                                                                                                                                                                                                              = &H9198&
Public Const GL_MAX_SPARSE_3D_TEXTURE_SIZE_ARB                                                                                                                                                                                                               = &H9199&
Public Const GL_MAX_SPARSE_ARRAY_TEXTURE_LAYERS_ARB                                                                                                                                                                                                              = &H919A&
Public Const GL_TEXTURE_SPARSE_ARB                                                                                                                                                                                                               = &H91A6&
Public Const GL_VIRTUAL_PAGE_SIZE_INDEX_ARB                                                                                                                                                                                                              = &H91A7&
Public Const GL_NUM_VIRTUAL_PAGE_SIZES_ARB                                                                                                                                                                                                               = &H91A8&
Public Const GL_SPARSE_TEXTURE_FULL_ARRAY_CUBE_MIPMAPS_ARB                                                                                                                                                                                                               = &H91A9&
Public Const GL_NUM_SPARSE_LEVELS_ARB                                                                                                                                                                                                                = &H91AA&
'------------------------------- GL_ARB_sparse_texture2 -------------------------------
'------------------------------- GL_ARB_sparse_texture_clamp -------------------------------
'------------------------------- GL_ARB_spirv_extensions -------------------------------
'public const GL_SPIR_V_EXTENSIONS                                                                                                                                                                                                               = &h9553&
'public const GL_NUM_SPIR_V_EXTENSIONS                                                                                                                                                                                                               = &h9554&
'------------------------------- GL_ARB_stencil_texturing -------------------------------
Public Const GL_DEPTH_STENCIL_TEXTURE_MODE                                                                                                                                                                                                               = &H90EA&
'------------------------------- GL_ARB_sync -------------------------------
Public Const GL_SYNC_FLUSH_COMMANDS_BIT                                                                                                                                                                                                              = &H1&
Public Const GL_MAX_SERVER_WAIT_TIMEOUT                                                                                                                                                                                                              = &H9111&
Public Const GL_OBJECT_TYPE                                                                                                                                                                                                              = &H9112&
Public Const GL_SYNC_CONDITION                                                                                                                                                                                                               = &H9113&
Public Const GL_SYNC_STATUS                                                                                                                                                                                                              = &H9114&
Public Const GL_SYNC_FLAGS                                                                                                                                                                                                               = &H9115&
Public Const GL_SYNC_FENCE                                                                                                                                                                                                               = &H9116&
Public Const GL_SYNC_GPU_COMMANDS_COMPLETE                                                                                                                                                                                                               = &H9117&
Public Const GL_UNSIGNALED                                                                                                                                                                                                               = &H9118&
Public Const GL_SIGNALED                                                                                                                                                                                                                 = &H9119&
Public Const GL_ALREADY_SIGNALED                                                                                                                                                                                                                 = &H911A&
Public Const GL_TIMEOUT_EXPIRED                                                                                                                                                                                                              = &H911B&
Public Const GL_CONDITION_SATISFIED                                                                                                                                                                                                              = &H911C&
Public Const GL_WAIT_FAILED                                                                                                                                                                                                              = &H911D&
'public const GL_TIMEOUT_IGNORED                                                                                                                                                                                                                 = &hFFFFFFFFFFFFFFFFull&
'------------------------------- GL_ARB_tessellation_shader -------------------------------
Public Const GL_PATCHES                                                                                                                                                                                                              = &HE&
Public Const GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER                                                                                                                                                                                                              = &H84F0&
Public Const GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER                                                                                                                                                                                                               = &H84F1&
Public Const GL_MAX_TESS_CONTROL_INPUT_COMPONENTS                                                                                                                                                                                                                = &H886C&
Public Const GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS                                                                                                                                                                                                                 = &H886D&
Public Const GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS                                                                                                                                                                                                                 = &H8E1E&
Public Const GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS                                                                                                                                                                                                              = &H8E1F&
Public Const GL_PATCH_VERTICES                                                                                                                                                                                                               = &H8E72&
Public Const GL_PATCH_DEFAULT_INNER_LEVEL                                                                                                                                                                                                                = &H8E73&
Public Const GL_PATCH_DEFAULT_OUTER_LEVEL                                                                                                                                                                                                                = &H8E74&
Public Const GL_TESS_CONTROL_OUTPUT_VERTICES                                                                                                                                                                                                                 = &H8E75&
Public Const GL_TESS_GEN_MODE                                                                                                                                                                                                                = &H8E76&
Public Const GL_TESS_GEN_SPACING                                                                                                                                                                                                                 = &H8E77&
Public Const GL_TESS_GEN_VERTEX_ORDER                                                                                                                                                                                                                = &H8E78&
Public Const GL_TESS_GEN_POINT_MODE                                                                                                                                                                                                              = &H8E79&
Public Const GL_ISOLINES                                                                                                                                                                                                                 = &H8E7A&
Public Const GL_FRACTIONAL_ODD                                                                                                                                                                                                               = &H8E7B&
Public Const GL_FRACTIONAL_EVEN                                                                                                                                                                                                              = &H8E7C&
Public Const GL_MAX_PATCH_VERTICES                                                                                                                                                                                                               = &H8E7D&
Public Const GL_MAX_TESS_GEN_LEVEL                                                                                                                                                                                                               = &H8E7E&
Public Const GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS                                                                                                                                                                                                              = &H8E7F&
Public Const GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS                                                                                                                                                                                                               = &H8E80&
Public Const GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS                                                                                                                                                                                                                 = &H8E81&
Public Const GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS                                                                                                                                                                                                              = &H8E82&
Public Const GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS                                                                                                                                                                                                               = &H8E83&
Public Const GL_MAX_TESS_PATCH_COMPONENTS                                                                                                                                                                                                                = &H8E84&
Public Const GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS                                                                                                                                                                                                                 = &H8E85&
Public Const GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS                                                                                                                                                                                                                = &H8E86&
Public Const GL_TESS_EVALUATION_SHADER                                                                                                                                                                                                               = &H8E87&
Public Const GL_TESS_CONTROL_SHADER                                                                                                                                                                                                              = &H8E88&
Public Const GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS                                                                                                                                                                                                              = &H8E89&
Public Const GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS                                                                                                                                                                                                               = &H8E8A&
'------------------------------- GL_ARB_texture_barrier -------------------------------
'------------------------------- GL_ARB_texture_border_clamp -------------------------------
Public Const GL_CLAMP_TO_BORDER_ARB                                                                                                                                                                                                              = &H812D&
'------------------------------- GL_ARB_texture_buffer_object -------------------------------
Public Const GL_TEXTURE_BUFFER_ARB                                                                                                                                                                                                               = &H8C2A&
Public Const GL_MAX_TEXTURE_BUFFER_SIZE_ARB                                                                                                                                                                                                              = &H8C2B&
Public Const GL_TEXTURE_BINDING_BUFFER_ARB                                                                                                                                                                                                               = &H8C2C&
Public Const GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB                                                                                                                                                                                                                = &H8C2D&
Public Const GL_TEXTURE_BUFFER_FORMAT_ARB                                                                                                                                                                                                                = &H8C2E&
'------------------------------- GL_ARB_texture_buffer_object_rgb32 -------------------------------
'------------------------------- GL_ARB_texture_buffer_range -------------------------------
Public Const GL_TEXTURE_BUFFER_OFFSET                                                                                                                                                                                                                = &H919D&
Public Const GL_TEXTURE_BUFFER_SIZE                                                                                                                                                                                                              = &H919E&
Public Const GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT                                                                                                                                                                                                              = &H919F&
'------------------------------- GL_ARB_texture_compression -------------------------------
Public Const GL_COMPRESSED_ALPHA_ARB                                                                                                                                                                                                                 = &H84E9&
Public Const GL_COMPRESSED_LUMINANCE_ARB                                                                                                                                                                                                                 = &H84EA&
Public Const GL_COMPRESSED_LUMINANCE_ALPHA_ARB                                                                                                                                                                                                               = &H84EB&
Public Const GL_COMPRESSED_INTENSITY_ARB                                                                                                                                                                                                                 = &H84EC&
Public Const GL_COMPRESSED_RGB_ARB                                                                                                                                                                                                               = &H84ED&
Public Const GL_COMPRESSED_RGBA_ARB                                                                                                                                                                                                              = &H84EE&
Public Const GL_TEXTURE_COMPRESSION_HINT_ARB                                                                                                                                                                                                                 = &H84EF&
Public Const GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB                                                                                                                                                                                                                = &H86A0&
Public Const GL_TEXTURE_COMPRESSED_ARB                                                                                                                                                                                                               = &H86A1&
Public Const GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB                                                                                                                                                                                                               = &H86A2&
Public Const GL_COMPRESSED_TEXTURE_FORMATS_ARB                                                                                                                                                                                                               = &H86A3&
'------------------------------- GL_ARB_texture_compression_bptc -------------------------------
Public Const GL_COMPRESSED_RGBA_BPTC_UNORM_ARB                                                                                                                                                                                                               = &H8E8C&
Public Const GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB                                                                                                                                                                                                                 = &H8E8D&
Public Const GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB                                                                                                                                                                                                                 = &H8E8E&
Public Const GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB                                                                                                                                                                                                               = &H8E8F&
'------------------------------- GL_ARB_texture_compression_rgtc -------------------------------
Public Const GL_COMPRESSED_RED_RGTC1                                                                                                                                                                                                                 = &H8DBB&
Public Const GL_COMPRESSED_SIGNED_RED_RGTC1                                                                                                                                                                                                              = &H8DBC&
Public Const GL_COMPRESSED_RG_RGTC2                                                                                                                                                                                                              = &H8DBD&
Public Const GL_COMPRESSED_SIGNED_RG_RGTC2                                                                                                                                                                                                               = &H8DBE&
'------------------------------- GL_ARB_texture_cube_map -------------------------------
Public Const GL_NORMAL_MAP_ARB                                                                                                                                                                                                               = &H8511&
Public Const GL_REFLECTION_MAP_ARB                                                                                                                                                                                                               = &H8512&
Public Const GL_TEXTURE_CUBE_MAP_ARB                                                                                                                                                                                                                 = &H8513&
Public Const GL_TEXTURE_BINDING_CUBE_MAP_ARB                                                                                                                                                                                                                 = &H8514&
Public Const GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB                                                                                                                                                                                                              = &H8515&
Public Const GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB                                                                                                                                                                                                              = &H8516&
Public Const GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB                                                                                                                                                                                                              = &H8517&
Public Const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB                                                                                                                                                                                                              = &H8518&
Public Const GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB                                                                                                                                                                                                              = &H8519&
Public Const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB                                                                                                                                                                                                              = &H851A&
Public Const GL_PROXY_TEXTURE_CUBE_MAP_ARB                                                                                                                                                                                                               = &H851B&
Public Const GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB                                                                                                                                                                                                                = &H851C&
'------------------------------- GL_ARB_texture_cube_map_array -------------------------------
Public Const GL_TEXTURE_CUBE_MAP_ARRAY_ARB                                                                                                                                                                                                               = &H9009&
Public Const GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB                                                                                                                                                                                                               = &H900A&
Public Const GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB                                                                                                                                                                                                                 = &H900B&
Public Const GL_SAMPLER_CUBE_MAP_ARRAY_ARB                                                                                                                                                                                                               = &H900C&
Public Const GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB                                                                                                                                                                                                                = &H900D&
Public Const GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB                                                                                                                                                                                                               = &H900E&
Public Const GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB                                                                                                                                                                                                              = &H900F&
'------------------------------- GL_ARB_texture_env_add -------------------------------
'------------------------------- GL_ARB_texture_env_combine -------------------------------
Public Const GL_SUBTRACT_ARB                                                                                                                                                                                                                 = &H84E7&
Public Const GL_COMBINE_ARB                                                                                                                                                                                                              = &H8570&
Public Const GL_COMBINE_RGB_ARB                                                                                                                                                                                                              = &H8571&
Public Const GL_COMBINE_ALPHA_ARB                                                                                                                                                                                                                = &H8572&
Public Const GL_RGB_SCALE_ARB                                                                                                                                                                                                                = &H8573&
Public Const GL_ADD_SIGNED_ARB                                                                                                                                                                                                               = &H8574&
Public Const GL_INTERPOLATE_ARB                                                                                                                                                                                                              = &H8575&
Public Const GL_CONSTANT_ARB                                                                                                                                                                                                                 = &H8576&
Public Const GL_PRIMARY_COLOR_ARB                                                                                                                                                                                                                = &H8577&
Public Const GL_PREVIOUS_ARB                                                                                                                                                                                                                 = &H8578&
Public Const GL_SOURCE0_RGB_ARB                                                                                                                                                                                                              = &H8580&
Public Const GL_SOURCE1_RGB_ARB                                                                                                                                                                                                              = &H8581&
Public Const GL_SOURCE2_RGB_ARB                                                                                                                                                                                                              = &H8582&
Public Const GL_SOURCE0_ALPHA_ARB                                                                                                                                                                                                                = &H8588&
Public Const GL_SOURCE1_ALPHA_ARB                                                                                                                                                                                                                = &H8589&
Public Const GL_SOURCE2_ALPHA_ARB                                                                                                                                                                                                                = &H858A&
Public Const GL_OPERAND0_RGB_ARB                                                                                                                                                                                                                 = &H8590&
Public Const GL_OPERAND1_RGB_ARB                                                                                                                                                                                                                 = &H8591&
Public Const GL_OPERAND2_RGB_ARB                                                                                                                                                                                                                 = &H8592&
Public Const GL_OPERAND0_ALPHA_ARB                                                                                                                                                                                                               = &H8598&
Public Const GL_OPERAND1_ALPHA_ARB                                                                                                                                                                                                               = &H8599&
Public Const GL_OPERAND2_ALPHA_ARB                                                                                                                                                                                                               = &H859A&
'------------------------------- GL_ARB_texture_env_crossbar -------------------------------
'------------------------------- GL_ARB_texture_env_dot3 -------------------------------
Public Const GL_DOT3_RGB_ARB                                                                                                                                                                                                                 = &H86AE&
Public Const GL_DOT3_RGBA_ARB                                                                                                                                                                                                                = &H86AF&
'------------------------------- GL_ARB_texture_filter_anisotropic -------------------------------
'public const GL_TEXTURE_MAX_ANISOTROPY                                                                                                                                                                                                              = &h84FE&
'public const GL_MAX_TEXTURE_MAX_ANISOTROPY                                                                                                                                                                                                              = &h84FF&
'------------------------------- GL_ARB_texture_filter_minmax -------------------------------
Public Const GL_TEXTURE_REDUCTION_MODE_ARB                                                                                                                                                                                                               = &H9366&
Public Const GL_WEIGHTED_AVERAGE_ARB                                                                                                                                                                                                                 = &H9367&
'------------------------------- GL_ARB_texture_float -------------------------------
Public Const GL_RGBA32F_ARB                                                                                                                                                                                                              = &H8814&
Public Const GL_RGB32F_ARB                                                                                                                                                                                                               = &H8815&
Public Const GL_ALPHA32F_ARB                                                                                                                                                                                                                 = &H8816&
Public Const GL_INTENSITY32F_ARB                                                                                                                                                                                                                 = &H8817&
Public Const GL_LUMINANCE32F_ARB                                                                                                                                                                                                                 = &H8818&
Public Const GL_LUMINANCE_ALPHA32F_ARB                                                                                                                                                                                                               = &H8819&
Public Const GL_RGBA16F_ARB                                                                                                                                                                                                              = &H881A&
Public Const GL_RGB16F_ARB                                                                                                                                                                                                               = &H881B&
Public Const GL_ALPHA16F_ARB                                                                                                                                                                                                                 = &H881C&
Public Const GL_INTENSITY16F_ARB                                                                                                                                                                                                                 = &H881D&
Public Const GL_LUMINANCE16F_ARB                                                                                                                                                                                                                 = &H881E&
Public Const GL_LUMINANCE_ALPHA16F_ARB                                                                                                                                                                                                               = &H881F&
Public Const GL_TEXTURE_RED_TYPE_ARB                                                                                                                                                                                                                 = &H8C10&
Public Const GL_TEXTURE_GREEN_TYPE_ARB                                                                                                                                                                                                               = &H8C11&
Public Const GL_TEXTURE_BLUE_TYPE_ARB                                                                                                                                                                                                                = &H8C12&
Public Const GL_TEXTURE_ALPHA_TYPE_ARB                                                                                                                                                                                                               = &H8C13&
Public Const GL_TEXTURE_LUMINANCE_TYPE_ARB                                                                                                                                                                                                               = &H8C14&
Public Const GL_TEXTURE_INTENSITY_TYPE_ARB                                                                                                                                                                                                               = &H8C15&
Public Const GL_TEXTURE_DEPTH_TYPE_ARB                                                                                                                                                                                                               = &H8C16&
Public Const GL_UNSIGNED_NORMALIZED_ARB                                                                                                                                                                                                              = &H8C17&
'------------------------------- GL_ARB_texture_gather -------------------------------
Public Const GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB                                                                                                                                                                                                                = &H8E5E&
Public Const GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB                                                                                                                                                                                                                = &H8E5F&
Public Const GL_MAX_PROGRAM_TEXTURE_GATHER_COMPONENTS_ARB                                                                                                                                                                                                                = &H8F9F&
'------------------------------- GL_ARB_texture_mirror_clamp_to_edge -------------------------------
Public Const GL_MIRROR_CLAMP_TO_EDGE                                                                                                                                                                                                                 = &H8743&
'------------------------------- GL_ARB_texture_mirrored_repeat -------------------------------
Public Const GL_MIRRORED_REPEAT_ARB                                                                                                                                                                                                              = &H8370&
'------------------------------- GL_ARB_texture_multisample -------------------------------
Public Const GL_SAMPLE_POSITION                                                                                                                                                                                                              = &H8E50&
Public Const GL_SAMPLE_MASK                                                                                                                                                                                                              = &H8E51&
Public Const GL_SAMPLE_MASK_VALUE                                                                                                                                                                                                                = &H8E52&
Public Const GL_MAX_SAMPLE_MASK_WORDS                                                                                                                                                                                                                = &H8E59&
Public Const GL_TEXTURE_2D_MULTISAMPLE                                                                                                                                                                                                               = &H9100&
Public Const GL_PROXY_TEXTURE_2D_MULTISAMPLE                                                                                                                                                                                                                 = &H9101&
Public Const GL_TEXTURE_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                                 = &H9102&
Public Const GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                               = &H9103&
Public Const GL_TEXTURE_BINDING_2D_MULTISAMPLE                                                                                                                                                                                                               = &H9104&
Public Const GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                                 = &H9105&
Public Const GL_TEXTURE_SAMPLES                                                                                                                                                                                                              = &H9106&
Public Const GL_TEXTURE_FIXED_SAMPLE_LOCATIONS                                                                                                                                                                                                               = &H9107&
Public Const GL_SAMPLER_2D_MULTISAMPLE                                                                                                                                                                                                               = &H9108&
Public Const GL_INT_SAMPLER_2D_MULTISAMPLE                                                                                                                                                                                                               = &H9109&
Public Const GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE                                                                                                                                                                                                              = &H910A&
Public Const GL_SAMPLER_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                                 = &H910B&
Public Const GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                                 = &H910C&
Public Const GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY                                                                                                                                                                                                                = &H910D&
Public Const GL_MAX_COLOR_TEXTURE_SAMPLES                                                                                                                                                                                                                = &H910E&
Public Const GL_MAX_DEPTH_TEXTURE_SAMPLES                                                                                                                                                                                                                = &H910F&
Public Const GL_MAX_INTEGER_SAMPLES                                                                                                                                                                                                              = &H9110&
'------------------------------- GL_ARB_texture_non_power_of_two -------------------------------
'------------------------------- GL_ARB_texture_query_levels -------------------------------
'------------------------------- GL_ARB_texture_query_lod -------------------------------
'------------------------------- GL_ARB_texture_rectangle -------------------------------
Public Const GL_TEXTURE_RECTANGLE_ARB                                                                                                                                                                                                                = &H84F5&
Public Const GL_TEXTURE_BINDING_RECTANGLE_ARB                                                                                                                                                                                                                = &H84F6&
Public Const GL_PROXY_TEXTURE_RECTANGLE_ARB                                                                                                                                                                                                              = &H84F7&
Public Const GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB                                                                                                                                                                                                               = &H84F8&
'public const GL_SAMPLER_2D_RECT_ARB                                                                                                                                                                                                                 = &h8B63&
'public const GL_SAMPLER_2D_RECT_SHADOW_ARB                                                                                                                                                                                                              = &h8B64&
'------------------------------- GL_ARB_texture_rg -------------------------------
Public Const GL_COMPRESSED_RED                                                                                                                                                                                                               = &H8225&
Public Const GL_COMPRESSED_RG                                                                                                                                                                                                                = &H8226&
Public Const GL_RG                                                                                                                                                                                                               = &H8227&
Public Const GL_RG_INTEGER                                                                                                                                                                                                               = &H8228&
Public Const GL_R8                                                                                                                                                                                                               = &H8229&
Public Const GL_R16                                                                                                                                                                                                              = &H822A&
Public Const GL_RG8                                                                                                                                                                                                              = &H822B&
Public Const GL_RG16                                                                                                                                                                                                                 = &H822C&
Public Const GL_R16F                                                                                                                                                                                                                 = &H822D&
Public Const GL_R32F                                                                                                                                                                                                                 = &H822E&
Public Const GL_RG16F                                                                                                                                                                                                                = &H822F&
Public Const GL_RG32F                                                                                                                                                                                                                = &H8230&
Public Const GL_R8I                                                                                                                                                                                                              = &H8231&
Public Const GL_R8UI                                                                                                                                                                                                                 = &H8232&
Public Const GL_R16I                                                                                                                                                                                                                 = &H8233&
Public Const GL_R16UI                                                                                                                                                                                                                = &H8234&
Public Const GL_R32I                                                                                                                                                                                                                 = &H8235&
Public Const GL_R32UI                                                                                                                                                                                                                = &H8236&
Public Const GL_RG8I                                                                                                                                                                                                                 = &H8237&
Public Const GL_RG8UI                                                                                                                                                                                                                = &H8238&
Public Const GL_RG16I                                                                                                                                                                                                                = &H8239&
Public Const GL_RG16UI                                                                                                                                                                                                               = &H823A&
Public Const GL_RG32I                                                                                                                                                                                                                = &H823B&
Public Const GL_RG32UI                                                                                                                                                                                                               = &H823C&
'------------------------------- GL_ARB_texture_rgb10_a2ui -------------------------------
'public const GL_RGB10_A2UI                                                                                                                                                                                                              = &h906F&
'------------------------------- GL_ARB_texture_stencil8 -------------------------------
'public const GL_STENCIL_INDEX                                                                                                                                                                                                               = &h1901&
'public const GL_STENCIL_INDEX8                                                                                                                                                                                                              = &h8D48&
'------------------------------- GL_ARB_texture_storage -------------------------------
Public Const GL_TEXTURE_IMMUTABLE_FORMAT                                                                                                                                                                                                                 = &H912F&
'------------------------------- GL_ARB_texture_storage_multisample -------------------------------
'------------------------------- GL_ARB_texture_swizzle -------------------------------
Public Const GL_TEXTURE_SWIZZLE_R                                                                                                                                                                                                                = &H8E42&
Public Const GL_TEXTURE_SWIZZLE_G                                                                                                                                                                                                                = &H8E43&
Public Const GL_TEXTURE_SWIZZLE_B                                                                                                                                                                                                                = &H8E44&
Public Const GL_TEXTURE_SWIZZLE_A                                                                                                                                                                                                                = &H8E45&
Public Const GL_TEXTURE_SWIZZLE_RGBA                                                                                                                                                                                                                 = &H8E46&
'------------------------------- GL_ARB_texture_view -------------------------------
Public Const GL_TEXTURE_VIEW_MIN_LEVEL                                                                                                                                                                                                               = &H82DB&
Public Const GL_TEXTURE_VIEW_NUM_LEVELS                                                                                                                                                                                                              = &H82DC&
Public Const GL_TEXTURE_VIEW_MIN_LAYER                                                                                                                                                                                                               = &H82DD&
Public Const GL_TEXTURE_VIEW_NUM_LAYERS                                                                                                                                                                                                              = &H82DE&
'public const GL_TEXTURE_IMMUTABLE_LEVELS                                                                                                                                                                                                                = &h82DF&
'------------------------------- GL_ARB_timer_query -------------------------------
Public Const GL_TIME_ELAPSED                                                                                                                                                                                                                 = &H88BF&
Public Const GL_TIMESTAMP                                                                                                                                                                                                                = &H8E28&
'------------------------------- GL_ARB_transform_feedback2 -------------------------------
Public Const GL_TRANSFORM_FEEDBACK                                                                                                                                                                                                               = &H8E22&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED                                                                                                                                                                                                                 = &H8E23&
Public Const GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE                                                                                                                                                                                                                 = &H8E24&
Public Const GL_TRANSFORM_FEEDBACK_BINDING                                                                                                                                                                                                               = &H8E25&
'------------------------------- GL_ARB_transform_feedback3 -------------------------------
Public Const GL_MAX_TRANSFORM_FEEDBACK_BUFFERS                                                                                                                                                                                                               = &H8E70&
'public const GL_MAX_VERTEX_STREAMS                                                                                                                                                                                                              = &h8E71&
'------------------------------- GL_ARB_transform_feedback_instanced -------------------------------
'------------------------------- GL_ARB_transform_feedback_overflow_query -------------------------------
Public Const GL_TRANSFORM_FEEDBACK_OVERFLOW_ARB                                                                                                                                                                                                              = &H82EC&
Public Const GL_TRANSFORM_FEEDBACK_STREAM_OVERFLOW_ARB                                                                                                                                                                                                               = &H82ED&
'------------------------------- GL_ARB_transpose_matrix -------------------------------
Public Const GL_TRANSPOSE_MODELVIEW_MATRIX_ARB                                                                                                                                                                                                               = &H84E3&
Public Const GL_TRANSPOSE_PROJECTION_MATRIX_ARB                                                                                                                                                                                                              = &H84E4&
Public Const GL_TRANSPOSE_TEXTURE_MATRIX_ARB                                                                                                                                                                                                                 = &H84E5&
Public Const GL_TRANSPOSE_COLOR_MATRIX_ARB                                                                                                                                                                                                               = &H84E6&
'------------------------------- GL_ARB_uniform_buffer_object -------------------------------
Public Const GL_UNIFORM_BUFFER                                                                                                                                                                                                               = &H8A11&
Public Const GL_UNIFORM_BUFFER_BINDING                                                                                                                                                                                                               = &H8A28&
Public Const GL_UNIFORM_BUFFER_START                                                                                                                                                                                                                 = &H8A29&
Public Const GL_UNIFORM_BUFFER_SIZE                                                                                                                                                                                                              = &H8A2A&
Public Const GL_MAX_VERTEX_UNIFORM_BLOCKS                                                                                                                                                                                                                = &H8A2B&
Public Const GL_MAX_GEOMETRY_UNIFORM_BLOCKS                                                                                                                                                                                                              = &H8A2C&
Public Const GL_MAX_FRAGMENT_UNIFORM_BLOCKS                                                                                                                                                                                                              = &H8A2D&
Public Const GL_MAX_COMBINED_UNIFORM_BLOCKS                                                                                                                                                                                                              = &H8A2E&
Public Const GL_MAX_UNIFORM_BUFFER_BINDINGS                                                                                                                                                                                                              = &H8A2F&
Public Const GL_MAX_UNIFORM_BLOCK_SIZE                                                                                                                                                                                                               = &H8A30&
Public Const GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS                                                                                                                                                                                                               = &H8A31&
Public Const GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS                                                                                                                                                                                                                 = &H8A32&
Public Const GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS                                                                                                                                                                                                                 = &H8A33&
Public Const GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT                                                                                                                                                                                                              = &H8A34&
Public Const GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH                                                                                                                                                                                                                 = &H8A35&
Public Const GL_ACTIVE_UNIFORM_BLOCKS                                                                                                                                                                                                                = &H8A36&
Public Const GL_UNIFORM_TYPE                                                                                                                                                                                                                 = &H8A37&
Public Const GL_UNIFORM_SIZE                                                                                                                                                                                                                 = &H8A38&
Public Const GL_UNIFORM_NAME_LENGTH                                                                                                                                                                                                              = &H8A39&
Public Const GL_UNIFORM_BLOCK_INDEX                                                                                                                                                                                                              = &H8A3A&
Public Const GL_UNIFORM_OFFSET                                                                                                                                                                                                               = &H8A3B&
Public Const GL_UNIFORM_ARRAY_STRIDE                                                                                                                                                                                                                 = &H8A3C&
Public Const GL_UNIFORM_MATRIX_STRIDE                                                                                                                                                                                                                = &H8A3D&
Public Const GL_UNIFORM_IS_ROW_MAJOR                                                                                                                                                                                                                 = &H8A3E&
Public Const GL_UNIFORM_BLOCK_BINDING                                                                                                                                                                                                                = &H8A3F&
Public Const GL_UNIFORM_BLOCK_DATA_SIZE                                                                                                                                                                                                              = &H8A40&
Public Const GL_UNIFORM_BLOCK_NAME_LENGTH                                                                                                                                                                                                                = &H8A41&
Public Const GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS                                                                                                                                                                                                                = &H8A42&
Public Const GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES                                                                                                                                                                                                                 = &H8A43&
Public Const GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER                                                                                                                                                                                                                = &H8A44&
Public Const GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER                                                                                                                                                                                                              = &H8A45&
Public Const GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER                                                                                                                                                                                                              = &H8A46&
'public const GL_INVALID_INDEX                                                                                                                                                                                                               = &hFFFFFFFFu&
'------------------------------- GL_ARB_vertex_array_bgra -------------------------------
'public const GL_BGRA                                                                                                                                                                                                                = &h80E1&
'------------------------------- GL_ARB_vertex_array_object -------------------------------
Public Const GL_VERTEX_ARRAY_BINDING                                                                                                                                                                                                                 = &H85B5&
'------------------------------- GL_ARB_vertex_attrib_64bit -------------------------------
'------------------------------- GL_ARB_vertex_attrib_binding -------------------------------
Public Const GL_VERTEX_ATTRIB_BINDING                                                                                                                                                                                                                = &H82D4&
Public Const GL_VERTEX_ATTRIB_RELATIVE_OFFSET                                                                                                                                                                                                                = &H82D5&
Public Const GL_VERTEX_BINDING_DIVISOR                                                                                                                                                                                                               = &H82D6&
Public Const GL_VERTEX_BINDING_OFFSET                                                                                                                                                                                                                = &H82D7&
Public Const GL_VERTEX_BINDING_STRIDE                                                                                                                                                                                                                = &H82D8&
Public Const GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET                                                                                                                                                                                                                = &H82D9&
Public Const GL_MAX_VERTEX_ATTRIB_BINDINGS                                                                                                                                                                                                               = &H82DA&
Public Const GL_VERTEX_BINDING_BUFFER                                                                                                                                                                                                                = &H8F4F&
'------------------------------- GL_ARB_vertex_blend -------------------------------
Public Const GL_MODELVIEW0_ARB                                                                                                                                                                                                               = &H1700&
Public Const GL_MODELVIEW1_ARB                                                                                                                                                                                                               = &H850A&
Public Const GL_MAX_VERTEX_UNITS_ARB                                                                                                                                                                                                                 = &H86A4&
Public Const GL_ACTIVE_VERTEX_UNITS_ARB                                                                                                                                                                                                              = &H86A5&
Public Const GL_WEIGHT_SUM_UNITY_ARB                                                                                                                                                                                                                 = &H86A6&
Public Const GL_VERTEX_BLEND_ARB                                                                                                                                                                                                                 = &H86A7&
Public Const GL_CURRENT_WEIGHT_ARB                                                                                                                                                                                                               = &H86A8&
Public Const GL_WEIGHT_ARRAY_TYPE_ARB                                                                                                                                                                                                                = &H86A9&
Public Const GL_WEIGHT_ARRAY_STRIDE_ARB                                                                                                                                                                                                              = &H86AA&
Public Const GL_WEIGHT_ARRAY_SIZE_ARB                                                                                                                                                                                                                = &H86AB&
Public Const GL_WEIGHT_ARRAY_POINTER_ARB                                                                                                                                                                                                                 = &H86AC&
Public Const GL_WEIGHT_ARRAY_ARB                                                                                                                                                                                                                 = &H86AD&
Public Const GL_MODELVIEW2_ARB                                                                                                                                                                                                               = &H8722&
Public Const GL_MODELVIEW3_ARB                                                                                                                                                                                                               = &H8723&
Public Const GL_MODELVIEW4_ARB                                                                                                                                                                                                               = &H8724&
Public Const GL_MODELVIEW5_ARB                                                                                                                                                                                                               = &H8725&
Public Const GL_MODELVIEW6_ARB                                                                                                                                                                                                               = &H8726&
Public Const GL_MODELVIEW7_ARB                                                                                                                                                                                                               = &H8727&
Public Const GL_MODELVIEW8_ARB                                                                                                                                                                                                               = &H8728&
Public Const GL_MODELVIEW9_ARB                                                                                                                                                                                                               = &H8729&
Public Const GL_MODELVIEW10_ARB                                                                                                                                                                                                              = &H872A&
Public Const GL_MODELVIEW11_ARB                                                                                                                                                                                                              = &H872B&
Public Const GL_MODELVIEW12_ARB                                                                                                                                                                                                              = &H872C&
Public Const GL_MODELVIEW13_ARB                                                                                                                                                                                                              = &H872D&
Public Const GL_MODELVIEW14_ARB                                                                                                                                                                                                              = &H872E&
Public Const GL_MODELVIEW15_ARB                                                                                                                                                                                                              = &H872F&
Public Const GL_MODELVIEW16_ARB                                                                                                                                                                                                              = &H8730&
Public Const GL_MODELVIEW17_ARB                                                                                                                                                                                                              = &H8731&
Public Const GL_MODELVIEW18_ARB                                                                                                                                                                                                              = &H8732&
Public Const GL_MODELVIEW19_ARB                                                                                                                                                                                                              = &H8733&
Public Const GL_MODELVIEW20_ARB                                                                                                                                                                                                              = &H8734&
Public Const GL_MODELVIEW21_ARB                                                                                                                                                                                                              = &H8735&
Public Const GL_MODELVIEW22_ARB                                                                                                                                                                                                              = &H8736&
Public Const GL_MODELVIEW23_ARB                                                                                                                                                                                                              = &H8737&
Public Const GL_MODELVIEW24_ARB                                                                                                                                                                                                              = &H8738&
Public Const GL_MODELVIEW25_ARB                                                                                                                                                                                                              = &H8739&
Public Const GL_MODELVIEW26_ARB                                                                                                                                                                                                              = &H873A&
Public Const GL_MODELVIEW27_ARB                                                                                                                                                                                                              = &H873B&
Public Const GL_MODELVIEW28_ARB                                                                                                                                                                                                              = &H873C&
Public Const GL_MODELVIEW29_ARB                                                                                                                                                                                                              = &H873D&
Public Const GL_MODELVIEW30_ARB                                                                                                                                                                                                              = &H873E&
Public Const GL_MODELVIEW31_ARB                                                                                                                                                                                                              = &H873F&
'------------------------------- GL_ARB_vertex_buffer_object -------------------------------
Public Const GL_BUFFER_SIZE_ARB                                                                                                                                                                                                              = &H8764&
Public Const GL_BUFFER_USAGE_ARB                                                                                                                                                                                                                 = &H8765&
Public Const GL_ARRAY_BUFFER_ARB                                                                                                                                                                                                                 = &H8892&
Public Const GL_ELEMENT_ARRAY_BUFFER_ARB                                                                                                                                                                                                                 = &H8893&
Public Const GL_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                                 = &H8894&
Public Const GL_ELEMENT_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                                 = &H8895&
Public Const GL_VERTEX_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                              = &H8896&
Public Const GL_NORMAL_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                              = &H8897&
Public Const GL_COLOR_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                               = &H8898&
Public Const GL_INDEX_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                               = &H8899&
Public Const GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                               = &H889A&
Public Const GL_EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                               = &H889B&
Public Const GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                                 = &H889C&
Public Const GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                              = &H889D&
Public Const GL_WEIGHT_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                              = &H889E&
Public Const GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB                                                                                                                                                                                                               = &H889F&
Public Const GL_READ_ONLY_ARB                                                                                                                                                                                                                = &H88B8&
Public Const GL_WRITE_ONLY_ARB                                                                                                                                                                                                               = &H88B9&
Public Const GL_READ_WRITE_ARB                                                                                                                                                                                                               = &H88BA&
Public Const GL_BUFFER_ACCESS_ARB                                                                                                                                                                                                                = &H88BB&
Public Const GL_BUFFER_MAPPED_ARB                                                                                                                                                                                                                = &H88BC&
Public Const GL_BUFFER_MAP_POINTER_ARB                                                                                                                                                                                                               = &H88BD&
Public Const GL_STREAM_DRAW_ARB                                                                                                                                                                                                              = &H88E0&
Public Const GL_STREAM_READ_ARB                                                                                                                                                                                                              = &H88E1&
Public Const GL_STREAM_COPY_ARB                                                                                                                                                                                                              = &H88E2&
Public Const GL_STATIC_DRAW_ARB                                                                                                                                                                                                              = &H88E4&
Public Const GL_STATIC_READ_ARB                                                                                                                                                                                                              = &H88E5&
Public Const GL_STATIC_COPY_ARB                                                                                                                                                                                                              = &H88E6&
Public Const GL_DYNAMIC_DRAW_ARB                                                                                                                                                                                                                 = &H88E8&
Public Const GL_DYNAMIC_READ_ARB                                                                                                                                                                                                                 = &H88E9&
Public Const GL_DYNAMIC_COPY_ARB                                                                                                                                                                                                                 = &H88EA&
'------------------------------- GL_ARB_vertex_program -------------------------------
Public Const GL_COLOR_SUM_ARB                                                                                                                                                                                                                = &H8458&
Public Const GL_VERTEX_PROGRAM_ARB                                                                                                                                                                                                               = &H8620&
Public Const GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB                                                                                                                                                                                                              = &H8622&
Public Const GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB                                                                                                                                                                                                                 = &H8623&
Public Const GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB                                                                                                                                                                                                               = &H8624&
Public Const GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB                                                                                                                                                                                                                 = &H8625&
Public Const GL_CURRENT_VERTEX_ATTRIB_ARB                                                                                                                                                                                                                = &H8626&
Public Const GL_PROGRAM_LENGTH_ARB                                                                                                                                                                                                               = &H8627&
Public Const GL_PROGRAM_STRING_ARB                                                                                                                                                                                                               = &H8628&
Public Const GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB                                                                                                                                                                                                               = &H862E&
Public Const GL_MAX_PROGRAM_MATRICES_ARB                                                                                                                                                                                                                 = &H862F&
Public Const GL_CURRENT_MATRIX_STACK_DEPTH_ARB                                                                                                                                                                                                               = &H8640&
Public Const GL_CURRENT_MATRIX_ARB                                                                                                                                                                                                               = &H8641&
Public Const GL_VERTEX_PROGRAM_POINT_SIZE_ARB                                                                                                                                                                                                                = &H8642&
Public Const GL_VERTEX_PROGRAM_TWO_SIDE_ARB                                                                                                                                                                                                              = &H8643&
Public Const GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB                                                                                                                                                                                                              = &H8645&
Public Const GL_PROGRAM_ERROR_POSITION_ARB                                                                                                                                                                                                               = &H864B&
Public Const GL_PROGRAM_BINDING_ARB                                                                                                                                                                                                              = &H8677&
Public Const GL_MAX_VERTEX_ATTRIBS_ARB                                                                                                                                                                                                               = &H8869&
Public Const GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB                                                                                                                                                                                                               = &H886A&
Public Const GL_PROGRAM_ERROR_STRING_ARB                                                                                                                                                                                                                 = &H8874&
Public Const GL_PROGRAM_FORMAT_ASCII_ARB                                                                                                                                                                                                                 = &H8875&
Public Const GL_PROGRAM_FORMAT_ARB                                                                                                                                                                                                               = &H8876&
Public Const GL_PROGRAM_INSTRUCTIONS_ARB                                                                                                                                                                                                                 = &H88A0&
Public Const GL_MAX_PROGRAM_INSTRUCTIONS_ARB                                                                                                                                                                                                                 = &H88A1&
Public Const GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB                                                                                                                                                                                                              = &H88A2&
Public Const GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB                                                                                                                                                                                                              = &H88A3&
Public Const GL_PROGRAM_TEMPORARIES_ARB                                                                                                                                                                                                              = &H88A4&
Public Const GL_MAX_PROGRAM_TEMPORARIES_ARB                                                                                                                                                                                                              = &H88A5&
Public Const GL_PROGRAM_NATIVE_TEMPORARIES_ARB                                                                                                                                                                                                               = &H88A6&
Public Const GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB                                                                                                                                                                                                               = &H88A7&
Public Const GL_PROGRAM_PARAMETERS_ARB                                                                                                                                                                                                               = &H88A8&
Public Const GL_MAX_PROGRAM_PARAMETERS_ARB                                                                                                                                                                                                               = &H88A9&
Public Const GL_PROGRAM_NATIVE_PARAMETERS_ARB                                                                                                                                                                                                                = &H88AA&
Public Const GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB                                                                                                                                                                                                                = &H88AB&
Public Const GL_PROGRAM_ATTRIBS_ARB                                                                                                                                                                                                              = &H88AC&
Public Const GL_MAX_PROGRAM_ATTRIBS_ARB                                                                                                                                                                                                              = &H88AD&
Public Const GL_PROGRAM_NATIVE_ATTRIBS_ARB                                                                                                                                                                                                               = &H88AE&
Public Const GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB                                                                                                                                                                                                               = &H88AF&
Public Const GL_PROGRAM_ADDRESS_REGISTERS_ARB                                                                                                                                                                                                                = &H88B0&
Public Const GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB                                                                                                                                                                                                                = &H88B1&
Public Const GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB                                                                                                                                                                                                                 = &H88B2&
Public Const GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB                                                                                                                                                                                                                 = &H88B3&
Public Const GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB                                                                                                                                                                                                                 = &H88B4&
Public Const GL_MAX_PROGRAM_ENV_PARAMETERS_ARB                                                                                                                                                                                                               = &H88B5&
Public Const GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB                                                                                                                                                                                                              = &H88B6&
Public Const GL_TRANSPOSE_CURRENT_MATRIX_ARB                                                                                                                                                                                                                 = &H88B7&
Public Const GL_MATRIX0_ARB                                                                                                                                                                                                              = &H88C0&
Public Const GL_MATRIX1_ARB                                                                                                                                                                                                              = &H88C1&
Public Const GL_MATRIX2_ARB                                                                                                                                                                                                              = &H88C2&
Public Const GL_MATRIX3_ARB                                                                                                                                                                                                              = &H88C3&
Public Const GL_MATRIX4_ARB                                                                                                                                                                                                              = &H88C4&
Public Const GL_MATRIX5_ARB                                                                                                                                                                                                              = &H88C5&
Public Const GL_MATRIX6_ARB                                                                                                                                                                                                              = &H88C6&
Public Const GL_MATRIX7_ARB                                                                                                                                                                                                              = &H88C7&
Public Const GL_MATRIX8_ARB                                                                                                                                                                                                              = &H88C8&
Public Const GL_MATRIX9_ARB                                                                                                                                                                                                              = &H88C9&
Public Const GL_MATRIX10_ARB                                                                                                                                                                                                                 = &H88CA&
Public Const GL_MATRIX11_ARB                                                                                                                                                                                                                 = &H88CB&
Public Const GL_MATRIX12_ARB                                                                                                                                                                                                                 = &H88CC&
Public Const GL_MATRIX13_ARB                                                                                                                                                                                                                 = &H88CD&
Public Const GL_MATRIX14_ARB                                                                                                                                                                                                                 = &H88CE&
Public Const GL_MATRIX15_ARB                                                                                                                                                                                                                 = &H88CF&
Public Const GL_MATRIX16_ARB                                                                                                                                                                                                                 = &H88D0&
Public Const GL_MATRIX17_ARB                                                                                                                                                                                                                 = &H88D1&
Public Const GL_MATRIX18_ARB                                                                                                                                                                                                                 = &H88D2&
Public Const GL_MATRIX19_ARB                                                                                                                                                                                                                 = &H88D3&
Public Const GL_MATRIX20_ARB                                                                                                                                                                                                                 = &H88D4&
Public Const GL_MATRIX21_ARB                                                                                                                                                                                                                 = &H88D5&
Public Const GL_MATRIX22_ARB                                                                                                                                                                                                                 = &H88D6&
Public Const GL_MATRIX23_ARB                                                                                                                                                                                                                 = &H88D7&
Public Const GL_MATRIX24_ARB                                                                                                                                                                                                                 = &H88D8&
Public Const GL_MATRIX25_ARB                                                                                                                                                                                                                 = &H88D9&
Public Const GL_MATRIX26_ARB                                                                                                                                                                                                                 = &H88DA&
Public Const GL_MATRIX27_ARB                                                                                                                                                                                                                 = &H88DB&
Public Const GL_MATRIX28_ARB                                                                                                                                                                                                                 = &H88DC&
Public Const GL_MATRIX29_ARB                                                                                                                                                                                                                 = &H88DD&
Public Const GL_MATRIX30_ARB                                                                                                                                                                                                                 = &H88DE&
Public Const GL_MATRIX31_ARB                                                                                                                                                                                                                 = &H88DF&
'------------------------------- GL_ARB_vertex_shader -------------------------------
Public Const GL_VERTEX_SHADER_ARB                        = &H8B31&
Public Const GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB        = &H8B4A&
Public Const GL_MAX_VARYING_FLOATS_ARB                   = &H8B4B&
Public Const GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB       = &H8B4C&
Public Const GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB     = &H8B4D&
Public Const GL_OBJECT_ACTIVE_ATTRIBUTES_ARB             = &H8B89&
Public Const GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB   = &H8B8A&
'------------------------------- GL_ARB_vertex_type_10f_11f_11f_rev -------------------------------
'public const GL_UNSIGNED_INT_10F_11F_11F_REV                                                                                                                                                                                                                = &h8C3B&
'------------------------------- GL_ARB_vertex_type_2_10_10_10_rev -------------------------------
Public Const GL_UNSIGNED_INT_2_10_10_10_REV      = &H8368&
Public Const GL_INT_2_10_10_10_REV               = &H8D9F&
'------------------------------- GL_ARB_viewport_array -------------------------------
'public const GL_DEPTH_RANGE                      = &h0B70&
'public const GL_VIEWPORT                         = &h0BA2&
'public const GL_SCISSOR_BOX                      = &h0C10&
'public const GL_SCISSOR_TEST                     = &h0C11&
Public Const GL_MAX_VIEWPORTS                     = &H825B&
Public Const GL_VIEWPORT_SUBPIXEL_BITS            = &H825C&
Public Const GL_VIEWPORT_BOUNDS_RANGE             = &H825D&
Public Const GL_LAYER_PROVOKING_VERTEX            = &H825E&
Public Const GL_VIEWPORT_INDEX_PROVOKING_VERTEX   = &H825F&
Public Const GL_UNDEFINED_VERTEX                  = &H8260&
'public const GL_FIRST_VERTEX_CONVENTION          = &h8E4D&
'public const GL_LAST_VERTEX_CONVENTION           = &h8E4E&
'public const GL_PROVOKING_VERTEX                 = &h8E4F&
'------------------------------- GL_ARB_window_pos -------------------------------
'***************************************************************************************
'*                                    Fonctions                                        *
'***************************************************************************************
Private glClearDepthfPtr, glDepthRangefPtr, glGetShaderPrecisionFormatPtr, glReleaseShaderCompilerPtr, glShaderBinaryPtr, glMemoryBarrierByRegionPtr, glPrimitiveBoundingBoxARBPtr, glDrawArraysInstancedBaseInstancePtr, glDrawElementsInstancedBaseInstancePtr, _
glDrawElementsInstancedBaseVertexBaseInstancePtr, glGetImageHandleARBPtr, glGetTextureHandleARBPtr, glGetTextureSamplerHandleARBPtr, glGetVertexAttribLui64vARBPtr, glIsImageHandleResidentARBPtr, glIsTextureHandleResidentARBPtr, glMakeImageHandleNonResidentARBPtr, glMakeImageHandleResidentARBPtr, glMakeTextureHandleNonResidentARBPtr, _
glMakeTextureHandleResidentARBPtr, glProgramUniformHandleui64ARBPtr, glProgramUniformHandleui64vARBPtr, glUniformHandleui64ARBPtr, glUniformHandleui64vARBPtr, glVertexAttribL1ui64ARBPtr, glVertexAttribL1ui64vARBPtr, glBindFragDataLocationIndexedPtr, glGetFragDataIndexPtr, glBufferStoragePtr, _
glCreateSyncFromCLeventARBPtr, glClearBufferDataPtr, glClearBufferSubDataPtr, glClearNamedBufferDataEXTPtr, glClearNamedBufferSubDataEXTPtr, glClearTexImagePtr, glClearTexSubImagePtr, glClipControlPtr, glClampColorARBPtr, glDispatchComputePtr, _
glDispatchComputeIndirectPtr, glDispatchComputeGroupSizeARBPtr, glCopyBufferSubDataPtr, glCopyImageSubDataPtr, glDebugMessageCallbackARBPtr, glDebugMessageControlARBPtr, glDebugMessageInsertARBPtr, glGetDebugMessageLogARBPtr, glBindTextureUnitPtr, glBlitNamedFramebufferPtr, _
glCheckNamedFramebufferStatusPtr, glClearNamedBufferDataPtr, glClearNamedBufferSubDataPtr, glClearNamedFramebufferfiPtr, glClearNamedFramebufferfvPtr, glClearNamedFramebufferivPtr, glClearNamedFramebufferuivPtr, glCompressedTextureSubImage1DPtr, glCompressedTextureSubImage2DPtr, glCompressedTextureSubImage3DPtr, _
glCopyNamedBufferSubDataPtr, glCopyTextureSubImage1DPtr, glCopyTextureSubImage2DPtr, glCopyTextureSubImage3DPtr, glCreateBuffersPtr, glCreateFramebuffersPtr, glCreateProgramPipelinesPtr, glCreateQueriesPtr, glCreateRenderbuffersPtr, glCreateSamplersPtr, _
glCreateTexturesPtr, glCreateTransformFeedbacksPtr, glCreateVertexArraysPtr, glDisableVertexArrayAttribPtr, glEnableVertexArrayAttribPtr, glFlushMappedNamedBufferRangePtr, glGenerateTextureMipmapPtr, glGetCompressedTextureImagePtr, glGetNamedBufferParameteri64vPtr, glGetNamedBufferParameterivPtr, _
glGetNamedBufferPointervPtr, glGetNamedBufferSubDataPtr, glGetNamedFramebufferAttachmentParameterivPtr, glGetNamedFramebufferParameterivPtr, glGetNamedRenderbufferParameterivPtr, glGetQueryBufferObjecti64vPtr, glGetQueryBufferObjectivPtr, glGetQueryBufferObjectui64vPtr, glGetQueryBufferObjectuivPtr, glGetTextureImagePtr, _
glGetTextureLevelParameterfvPtr, glGetTextureLevelParameterivPtr, glGetTextureParameterIivPtr, glGetTextureParameterIuivPtr, glGetTextureParameterfvPtr, glGetTextureParameterivPtr, glGetTransformFeedbacki64_vPtr, glGetTransformFeedbacki_vPtr, glGetTransformFeedbackivPtr, glGetVertexArrayIndexed64ivPtr, _
glGetVertexArrayIndexedivPtr, glGetVertexArrayivPtr, glInvalidateNamedFramebufferDataPtr, glInvalidateNamedFramebufferSubDataPtr, glNamedBufferDataPtr, glNamedBufferStoragePtr, glNamedBufferSubDataPtr, glNamedFramebufferDrawBufferPtr, glNamedFramebufferDrawBuffersPtr, glNamedFramebufferParameteriPtr, _
glNamedFramebufferReadBufferPtr, glNamedFramebufferRenderbufferPtr, glNamedFramebufferTexturePtr, glNamedFramebufferTextureLayerPtr, glNamedRenderbufferStoragePtr, glNamedRenderbufferStorageMultisamplePtr, glTextureBufferPtr, glTextureBufferRangePtr, glTextureParameterIivPtr, glTextureParameterIuivPtr, _
glTextureParameterfPtr, glTextureParameterfvPtr, glTextureParameteriPtr, glTextureParameterivPtr, glTextureStorage1DPtr, glTextureStorage2DPtr, glTextureStorage2DMultisamplePtr, glTextureStorage3DPtr, glTextureStorage3DMultisamplePtr, glTextureSubImage1DPtr, _
glTextureSubImage2DPtr, glTextureSubImage3DPtr, glTransformFeedbackBufferBasePtr, glTransformFeedbackBufferRangePtr, glUnmapNamedBufferPtr, glVertexArrayAttribBindingPtr, glVertexArrayAttribFormatPtr, glVertexArrayAttribIFormatPtr, glVertexArrayAttribLFormatPtr, glVertexArrayBindingDivisorPtr, _
glVertexArrayElementBufferPtr, glVertexArrayVertexBufferPtr, glVertexArrayVertexBuffersPtr, glDrawBuffersARBPtr, glBlendEquationSeparateiARBPtr, glBlendEquationiARBPtr, glBlendFuncSeparateiARBPtr, glBlendFunciARBPtr, glDrawElementsBaseVertexPtr, glDrawElementsInstancedBaseVertexPtr, _
glDrawRangeElementsBaseVertexPtr, glMultiDrawElementsBaseVertexPtr, glDrawArraysIndirectPtr, glDrawElementsIndirectPtr, glFramebufferParameteriPtr, glGetFramebufferParameterivPtr, glGetNamedFramebufferParameterivEXTPtr, glNamedFramebufferParameteriEXTPtr, glBindFramebufferPtr, glBindRenderbufferPtr, _
glBlitFramebufferPtr, glCheckFramebufferStatusPtr, glDeleteFramebuffersPtr, glDeleteRenderbuffersPtr, glFramebufferRenderbufferPtr, glFramebufferTexture1DPtr, glFramebufferTexture2DPtr, glFramebufferTexture3DPtr, glFramebufferTextureLayerPtr, glGenFramebuffersPtr, _
glGenRenderbuffersPtr, glGenerateMipmapPtr, glGetFramebufferAttachmentParameterivPtr, glGetRenderbufferParameterivPtr, glIsFramebufferPtr, glIsRenderbufferPtr, glRenderbufferStoragePtr, glRenderbufferStorageMultisamplePtr, glFramebufferTextureARBPtr, glFramebufferTextureFaceARBPtr, _
glFramebufferTextureLayerARBPtr, glProgramParameteriARBPtr, glGetProgramBinaryPtr, glProgramBinaryPtr, glProgramParameteriPtr, glGetCompressedTextureSubImagePtr, glGetTextureSubImagePtr, glSpecializeShaderARBPtr, glGetUniformdvPtr, glUniform1dPtr, _
glUniform1dvPtr, glUniform2dPtr, glUniform2dvPtr, glUniform3dPtr, glUniform3dvPtr, glUniform4dPtr, glUniform4dvPtr, glUniformMatrix2dvPtr, glUniformMatrix2x3dvPtr, glUniformMatrix2x4dvPtr
Private glUniformMatrix3dvPtr, glUniformMatrix3x2dvPtr, glUniformMatrix3x4dvPtr, glUniformMatrix4dvPtr, glUniformMatrix4x2dvPtr, glUniformMatrix4x3dvPtr, glGetUniformi64vARBPtr, glGetUniformui64vARBPtr, glGetnUniformi64vARBPtr, glGetnUniformui64vARBPtr, _
glProgramUniform1i64ARBPtr, glProgramUniform1i64vARBPtr, glProgramUniform1ui64ARBPtr, glProgramUniform1ui64vARBPtr, glProgramUniform2i64ARBPtr, glProgramUniform2i64vARBPtr, glProgramUniform2ui64ARBPtr, glProgramUniform2ui64vARBPtr, glProgramUniform3i64ARBPtr, glProgramUniform3i64vARBPtr, _
glProgramUniform3ui64ARBPtr, glProgramUniform3ui64vARBPtr, glProgramUniform4i64ARBPtr, glProgramUniform4i64vARBPtr, glProgramUniform4ui64ARBPtr, glProgramUniform4ui64vARBPtr, glUniform1i64ARBPtr, glUniform1i64vARBPtr, glUniform1ui64ARBPtr, glUniform1ui64vARBPtr, _
glUniform2i64ARBPtr, glUniform2i64vARBPtr, glUniform2ui64ARBPtr, glUniform2ui64vARBPtr, glUniform3i64ARBPtr, glUniform3i64vARBPtr, glUniform3ui64ARBPtr, glUniform3ui64vARBPtr, glUniform4i64ARBPtr, glUniform4i64vARBPtr, _
glUniform4ui64ARBPtr, glUniform4ui64vARBPtr, glColorSubTablePtr, glColorTablePtr, glColorTableParameterfvPtr, glColorTableParameterivPtr, glConvolutionFilter1DPtr, glConvolutionFilter2DPtr, glConvolutionParameterfPtr, glConvolutionParameterfvPtr, _
glConvolutionParameteriPtr, glConvolutionParameterivPtr, glCopyColorSubTablePtr, glCopyColorTablePtr, glCopyConvolutionFilter1DPtr, glCopyConvolutionFilter2DPtr, glGetColorTablePtr, glGetColorTableParameterfvPtr, glGetColorTableParameterivPtr, glGetConvolutionFilterPtr, _
glGetConvolutionParameterfvPtr, glGetConvolutionParameterivPtr, glGetHistogramPtr, glGetHistogramParameterfvPtr, glGetHistogramParameterivPtr, glGetMinmaxPtr, glGetMinmaxParameterfvPtr, glGetMinmaxParameterivPtr, glGetSeparableFilterPtr, glHistogramPtr, _
glMinmaxPtr, glResetHistogramPtr, glResetMinmaxPtr, glSeparableFilter2DPtr, glMultiDrawArraysIndirectCountARBPtr, glMultiDrawElementsIndirectCountARBPtr, glDrawArraysInstancedARBPtr, glDrawElementsInstancedARBPtr, glVertexAttribDivisorARBPtr, glGetInternalformativPtr, _
glGetInternalformati64vPtr, glInvalidateBufferDataPtr, glInvalidateBufferSubDataPtr, glInvalidateFramebufferPtr, glInvalidateSubFramebufferPtr, glInvalidateTexImagePtr, glInvalidateTexSubImagePtr, glFlushMappedBufferRangePtr, glCurrentPaletteMatrixARBPtr, glMatrixIndexPointerARBPtr, _
glMatrixIndexubvARBPtr, glMatrixIndexuivARBPtr, glMatrixIndexusvARBPtr, glBindBuffersBasePtr, glBindBuffersRangePtr, glBindImageTexturesPtr, glBindSamplersPtr, glBindTexturesPtr, glBindVertexBuffersPtr, glMultiDrawArraysIndirectPtr, _
glMultiDrawElementsIndirectPtr, glSampleCoverageARBPtr, glActiveTextureARBPtr, glClientActiveTextureARBPtr, glMultiTexCoord1dARBPtr, glMultiTexCoord1dvARBPtr, glMultiTexCoord1fARBPtr, glMultiTexCoord1fvARBPtr, glMultiTexCoord1iARBPtr, glMultiTexCoord1ivARBPtr, _
glMultiTexCoord1sARBPtr, glMultiTexCoord1svARBPtr, glMultiTexCoord2dARBPtr, glMultiTexCoord2dvARBPtr, glMultiTexCoord2fARBPtr, glMultiTexCoord2fvARBPtr, glMultiTexCoord2iARBPtr, glMultiTexCoord2ivARBPtr, glMultiTexCoord2sARBPtr, glMultiTexCoord2svARBPtr, _
glMultiTexCoord3dARBPtr, glMultiTexCoord3dvARBPtr, glMultiTexCoord3fARBPtr, glMultiTexCoord3fvARBPtr, glMultiTexCoord3iARBPtr, glMultiTexCoord3ivARBPtr, glMultiTexCoord3sARBPtr, glMultiTexCoord3svARBPtr, glMultiTexCoord4dARBPtr, glMultiTexCoord4dvARBPtr, _
glMultiTexCoord4fARBPtr, glMultiTexCoord4fvARBPtr, glMultiTexCoord4iARBPtr, glMultiTexCoord4ivARBPtr, glMultiTexCoord4sARBPtr, glMultiTexCoord4svARBPtr, glBeginQueryARBPtr, glDeleteQueriesARBPtr, glEndQueryARBPtr, glGenQueriesARBPtr, _
glGetQueryObjectivARBPtr, glGetQueryObjectuivARBPtr, glGetQueryivARBPtr, glIsQueryARBPtr, glMaxShaderCompilerThreadsARBPtr, glPointParameterfARBPtr, glPointParameterfvARBPtr, glPolygonOffsetClampPtr, glGetProgramInterfaceivPtr, glGetProgramResourceIndexPtr, _
glGetProgramResourceLocationPtr, glGetProgramResourceLocationIndexPtr, glGetProgramResourceNamePtr, glGetProgramResourceivPtr, glProvokingVertexPtr, glGetGraphicsResetStatusARBPtr, glGetnColorTableARBPtr, glGetnCompressedTexImageARBPtr, glGetnConvolutionFilterARBPtr, glGetnHistogramARBPtr, _
glGetnMapdvARBPtr, glGetnMapfvARBPtr, glGetnMapivARBPtr, glGetnMinmaxARBPtr, glGetnPixelMapfvARBPtr, glGetnPixelMapuivARBPtr, glGetnPixelMapusvARBPtr, glGetnPolygonStippleARBPtr, glGetnSeparableFilterARBPtr, glGetnTexImageARBPtr, _
glGetnUniformdvARBPtr, glGetnUniformfvARBPtr, glGetnUniformivARBPtr, glGetnUniformuivARBPtr, glReadnPixelsARBPtr, glFramebufferSampleLocationsfvARBPtr, glNamedFramebufferSampleLocationsfvARBPtr, glMinSampleShadingARBPtr, glBindSamplerPtr, glDeleteSamplersPtr, _
glGenSamplersPtr, glGetSamplerParameterIivPtr, glGetSamplerParameterIuivPtr, glGetSamplerParameterfvPtr, glGetSamplerParameterivPtr, glIsSamplerPtr, glSamplerParameterIivPtr, glSamplerParameterIuivPtr, glSamplerParameterfPtr, glSamplerParameterfvPtr, _
glSamplerParameteriPtr, glSamplerParameterivPtr, glActiveShaderProgramPtr, glBindProgramPipelinePtr, glCreateShaderProgramvPtr, glDeleteProgramPipelinesPtr, glGenProgramPipelinesPtr, glGetProgramPipelineInfoLogPtr, glGetProgramPipelineivPtr, glIsProgramPipelinePtr
Private glProgramUniform1dPtr, glProgramUniform1dvPtr, glProgramUniform1fPtr, glProgramUniform1fvPtr, glProgramUniform1iPtr, glProgramUniform1ivPtr, glProgramUniform1uiPtr, glProgramUniform1uivPtr, glProgramUniform2dPtr, glProgramUniform2dvPtr, _
glProgramUniform2fPtr, glProgramUniform2fvPtr, glProgramUniform2iPtr, glProgramUniform2ivPtr, glProgramUniform2uiPtr, glProgramUniform2uivPtr, glProgramUniform3dPtr, glProgramUniform3dvPtr, glProgramUniform3fPtr, glProgramUniform3fvPtr, _
glProgramUniform3iPtr, glProgramUniform3ivPtr, glProgramUniform3uiPtr, glProgramUniform3uivPtr, glProgramUniform4dPtr, glProgramUniform4dvPtr, glProgramUniform4fPtr, glProgramUniform4fvPtr, glProgramUniform4iPtr, glProgramUniform4ivPtr, _
glProgramUniform4uiPtr, glProgramUniform4uivPtr, glProgramUniformMatrix2dvPtr, glProgramUniformMatrix2fvPtr, glProgramUniformMatrix2x3dvPtr, glProgramUniformMatrix2x3fvPtr, glProgramUniformMatrix2x4dvPtr, glProgramUniformMatrix2x4fvPtr, glProgramUniformMatrix3dvPtr, glProgramUniformMatrix3fvPtr, _
glProgramUniformMatrix3x2dvPtr, glProgramUniformMatrix3x2fvPtr, glProgramUniformMatrix3x4dvPtr, glProgramUniformMatrix3x4fvPtr, glProgramUniformMatrix4dvPtr, glProgramUniformMatrix4fvPtr, glProgramUniformMatrix4x2dvPtr, glProgramUniformMatrix4x2fvPtr, glProgramUniformMatrix4x3dvPtr, glProgramUniformMatrix4x3fvPtr, _
glUseProgramStagesPtr, glValidateProgramPipelinePtr, glGetActiveAtomicCounterBufferivPtr, glBindImageTexturePtr, glMemoryBarrierPtr, glAttachObjectARBPtr, glCompileShaderARBPtr, glCreateProgramObjectARBPtr, glCreateShaderObjectARBPtr, glDeleteObjectARBPtr, _
glDetachObjectARBPtr, glGetActiveUniformARBPtr, glGetAttachedObjectsARBPtr, glGetHandleARBPtr, glGetInfoLogARBPtr, glGetObjectParameterfvARBPtr, glGetObjectParameterivARBPtr, glGetShaderSourceARBPtr, glGetUniformLocationARBPtr, glGetUniformfvARBPtr, _
glGetUniformivARBPtr, glLinkProgramARBPtr, glShaderSourceARBPtr, glUniform1fARBPtr, glUniform1fvARBPtr, glUniform1iARBPtr, glUniform1ivARBPtr, glUniform2fARBPtr, glUniform2fvARBPtr, glUniform2iARBPtr, _
glUniform2ivARBPtr, glUniform3fARBPtr, glUniform3fvARBPtr, glUniform3iARBPtr, glUniform3ivARBPtr, glUniform4fARBPtr, glUniform4fvARBPtr, glUniform4iARBPtr, glUniform4ivARBPtr, glUniformMatrix2fvARBPtr, _
glUniformMatrix3fvARBPtr, glUniformMatrix4fvARBPtr, glUseProgramObjectARBPtr, glValidateProgramARBPtr, glShaderStorageBlockBindingPtr, glGetActiveSubroutineNamePtr, glGetActiveSubroutineUniformNamePtr, glGetActiveSubroutineUniformivPtr, glGetProgramStageivPtr, glGetSubroutineIndexPtr, _
glGetSubroutineUniformLocationPtr, glGetUniformSubroutineuivPtr, glUniformSubroutinesuivPtr, glCompileShaderIncludeARBPtr, glDeleteNamedStringARBPtr, glGetNamedStringARBPtr, glGetNamedStringivARBPtr, glIsNamedStringARBPtr, glNamedStringARBPtr, glBufferPageCommitmentARBPtr, _
glTexPageCommitmentARBPtr, glClientWaitSyncPtr, glDeleteSyncPtr, glFenceSyncPtr, glGetInteger64vPtr, glGetSyncivPtr, glIsSyncPtr, glWaitSyncPtr, glPatchParameterfvPtr, glPatchParameteriPtr, _
glTextureBarrierPtr, glTexBufferARBPtr, glTexBufferRangePtr, glTextureBufferRangeEXTPtr, glCompressedTexImage1DARBPtr, glCompressedTexImage2DARBPtr, glCompressedTexImage3DARBPtr, glCompressedTexSubImage1DARBPtr, glCompressedTexSubImage2DARBPtr, glCompressedTexSubImage3DARBPtr, _
glGetCompressedTexImageARBPtr, glGetMultisamplefvPtr, glSampleMaskiPtr, glTexImage2DMultisamplePtr, glTexImage3DMultisamplePtr, glTexStorage1DPtr, glTexStorage2DPtr, glTexStorage3DPtr, glTexStorage2DMultisamplePtr, glTexStorage3DMultisamplePtr, _
glTextureStorage2DMultisampleEXTPtr, glTextureStorage3DMultisampleEXTPtr, glTextureViewPtr, glGetQueryObjecti64vPtr, glGetQueryObjectui64vPtr, glQueryCounterPtr, glBindTransformFeedbackPtr, glDeleteTransformFeedbacksPtr, glDrawTransformFeedbackPtr, glGenTransformFeedbacksPtr, _
glIsTransformFeedbackPtr, glPauseTransformFeedbackPtr, glResumeTransformFeedbackPtr, glBeginQueryIndexedPtr, glDrawTransformFeedbackStreamPtr, glEndQueryIndexedPtr, glGetQueryIndexedivPtr, glDrawTransformFeedbackInstancedPtr, glDrawTransformFeedbackStreamInstancedPtr, glLoadTransposeMatrixdARBPtr, _
glLoadTransposeMatrixfARBPtr, glMultTransposeMatrixdARBPtr, glMultTransposeMatrixfARBPtr, glBindBufferBasePtr, glBindBufferRangePtr, glGetActiveUniformBlockNamePtr, glGetActiveUniformBlockivPtr, glGetActiveUniformNamePtr, glGetActiveUniformsivPtr, glGetIntegeri_vPtr, _
glGetUniformBlockIndexPtr, glGetUniformIndicesPtr, glUniformBlockBindingPtr, glBindVertexArrayARBPtr, glDeleteVertexArraysARBPtr, glGenVertexArraysARBPtr, glIsVertexArrayARBPtr, glGetVertexAttribLdvPtr, glVertexAttribL1dPtr, glVertexAttribL1dvPtr, _
glVertexAttribL2dPtr, glVertexAttribL2dvPtr, glVertexAttribL3dPtr, glVertexAttribL3dvPtr, glVertexAttribL4dPtr, glVertexAttribL4dvPtr, glVertexAttribLPointerPtr, glBindVertexBufferPtr, glVertexArrayBindVertexBufferEXTPtr, glVertexArrayVertexAttribBindingEXTPtr, _
glVertexArrayVertexAttribFormatEXTPtr, glVertexArrayVertexAttribIFormatEXTPtr, glVertexArrayVertexAttribLFormatEXTPtr, glVertexArrayVertexBindingDivisorEXTPtr, glVertexAttribBindingPtr, glVertexAttribFormatPtr, glVertexAttribIFormatPtr, glVertexAttribLFormatPtr, glVertexBindingDivisorPtr, glVertexBlendARBPtr
Private glWeightPointerARBPtr, glWeightbvARBPtr, glWeightdvARBPtr, glWeightfvARBPtr, glWeightivARBPtr, glWeightsvARBPtr, glWeightubvARBPtr, glWeightuivARBPtr, glWeightusvARBPtr, glBindBufferARBPtr, _
glBufferDataARBPtr, glBufferSubDataARBPtr, glDeleteBuffersARBPtr, glGenBuffersARBPtr, glGetBufferParameterivARBPtr, glGetBufferPointervARBPtr, glGetBufferSubDataARBPtr, glIsBufferARBPtr, glUnmapBufferARBPtr, glBindProgramARBPtr, _
glDeleteProgramsARBPtr, glDisableVertexAttribArrayARBPtr, glEnableVertexAttribArrayARBPtr, glGenProgramsARBPtr, glGetProgramEnvParameterdvARBPtr, glGetProgramEnvParameterfvARBPtr, glGetProgramLocalParameterdvARBPtr, glGetProgramLocalParameterfvARBPtr, glGetProgramStringARBPtr, glGetProgramivARBPtr, _
glGetVertexAttribPointervARBPtr, glGetVertexAttribdvARBPtr, glGetVertexAttribfvARBPtr, glGetVertexAttribivARBPtr, glIsProgramARBPtr, glProgramEnvParameter4dARBPtr, glProgramEnvParameter4dvARBPtr, glProgramEnvParameter4fARBPtr, glProgramEnvParameter4fvARBPtr, glProgramLocalParameter4dARBPtr, _
glProgramLocalParameter4dvARBPtr, glProgramLocalParameter4fARBPtr, glProgramLocalParameter4fvARBPtr, glProgramStringARBPtr, glVertexAttrib1dARBPtr, glVertexAttrib1dvARBPtr, glVertexAttrib1fARBPtr, glVertexAttrib1fvARBPtr, glVertexAttrib1sARBPtr, glVertexAttrib1svARBPtr, _
glVertexAttrib2dARBPtr, glVertexAttrib2dvARBPtr, glVertexAttrib2fARBPtr, glVertexAttrib2fvARBPtr, glVertexAttrib2sARBPtr, glVertexAttrib2svARBPtr, glVertexAttrib3dARBPtr, glVertexAttrib3dvARBPtr, glVertexAttrib3fARBPtr, glVertexAttrib3fvARBPtr, _
glVertexAttrib3sARBPtr, glVertexAttrib3svARBPtr, glVertexAttrib4NbvARBPtr, glVertexAttrib4NivARBPtr, glVertexAttrib4NsvARBPtr, glVertexAttrib4NubARBPtr, glVertexAttrib4NubvARBPtr, glVertexAttrib4NuivARBPtr, glVertexAttrib4NusvARBPtr, glVertexAttrib4bvARBPtr, _
glVertexAttrib4dARBPtr, glVertexAttrib4dvARBPtr, glVertexAttrib4fARBPtr, glVertexAttrib4fvARBPtr, glVertexAttrib4ivARBPtr, glVertexAttrib4sARBPtr, glVertexAttrib4svARBPtr, glVertexAttrib4ubvARBPtr, glVertexAttrib4uivARBPtr, glVertexAttrib4usvARBPtr, _
glVertexAttribPointerARBPtr, glBindAttribLocationARBPtr, glGetActiveAttribARBPtr, glGetAttribLocationARBPtr, glColorP3uiPtr, glColorP3uivPtr, glColorP4uiPtr, glColorP4uivPtr, glMultiTexCoordP1uiPtr, glMultiTexCoordP1uivPtr, _
glMultiTexCoordP2uiPtr, glMultiTexCoordP2uivPtr, glMultiTexCoordP3uiPtr, glMultiTexCoordP3uivPtr, glMultiTexCoordP4uiPtr, glMultiTexCoordP4uivPtr, glNormalP3uiPtr, glNormalP3uivPtr, glSecondaryColorP3uiPtr, glSecondaryColorP3uivPtr, _
glTexCoordP1uiPtr, glTexCoordP1uivPtr, glTexCoordP2uiPtr, glTexCoordP2uivPtr, glTexCoordP3uiPtr, glTexCoordP3uivPtr, glTexCoordP4uiPtr, glTexCoordP4uivPtr, glVertexAttribP1uiPtr, glVertexAttribP1uivPtr, _
glVertexAttribP2uiPtr, glVertexAttribP2uivPtr, glVertexAttribP3uiPtr, glVertexAttribP3uivPtr, glVertexAttribP4uiPtr, glVertexAttribP4uivPtr, glVertexP2uiPtr, glVertexP2uivPtr, glVertexP3uiPtr, glVertexP3uivPtr, _
glVertexP4uiPtr, glVertexP4uivPtr, glDepthRangeArrayvPtr, glDepthRangeIndexedPtr, glGetDoublei_vPtr, glGetFloati_vPtr, glScissorArrayvPtr, glScissorIndexedPtr, glScissorIndexedvPtr, glViewportArrayvPtr, _
glViewportIndexedfPtr, glViewportIndexedfvPtr, glWindowPos2dARBPtr, glWindowPos2dvARBPtr, glWindowPos2fARBPtr, glWindowPos2fvARBPtr, glWindowPos2iARBPtr, glWindowPos2ivARBPtr, glWindowPos2sARBPtr, glWindowPos2svARBPtr, _
glWindowPos3dARBPtr, glWindowPos3dvARBPtr, glWindowPos3fARBPtr, glWindowPos3fvARBPtr, glWindowPos3iARBPtr, glWindowPos3ivARBPtr, glWindowPos3sARBPtr, glWindowPos3svARBPtr
'------------------------------- GL_ARB_ES2_compatibility -------------------------------
Public Sub glClearDepthf(ByVal d As Single): Call OpenGLExtCall1(glClearDepthfPtr, vbEmpty, d): End Sub
Public Sub glDepthRangef(ByVal n As Single, ByVal f As Single): Call OpenGLExtCall2(glDepthRangefPtr, vbEmpty, n, f): End Sub
Public Sub glGetShaderPrecisionFormat(ByVal shadertype As Long, ByVal precisiontype As Long, range As Long, precision As Long): Call OpenGLExtCall4(glGetShaderPrecisionFormatPtr, vbEmpty, shadertype, precisiontype, VarPtr(range), VarPtr(precision)): End Sub
Public Sub glReleaseShaderCompiler(): Call OpenGLExtCall0(glReleaseShaderCompilerPtr, vbEmpty): End Sub
Public Sub glShaderBinary(ByVal count As Long, shaders As Long, ByVal binaryFormat As Long, ByVal binary, ByVal length As Long): Call OpenGLExtCall5(glShaderBinaryPtr, vbEmpty, count, VarPtr(shaders), binaryFormat, binary, length): End Sub
'------------------------------- GL_ARB_ES3_1_compatibility -------------------------------
Public Sub glMemoryBarrierByRegion(ByVal barriers As Long): Call OpenGLExtCall1(glMemoryBarrierByRegionPtr, vbEmpty, barriers): End Sub
'------------------------------- GL_ARB_ES3_2_compatibility -------------------------------
Public Sub glPrimitiveBoundingBoxARB(ByVal minX As Single, ByVal minY As Single, ByVal minZ As Single, ByVal minW As Single, ByVal maxX As Single, ByVal maxY As Single, ByVal maxZ As Single, ByVal maxW As Single): Call OpenGLExtCall8(glPrimitiveBoundingBoxARBPtr, vbEmpty, minX, minY, minZ, minW, maxX, maxY, maxZ, maxW): End Sub
'------------------------------- GL_ARB_ES3_compatibility -------------------------------
'------------------------------- GL_ARB_arrays_of_arrays -------------------------------
'------------------------------- GL_ARB_base_instance -------------------------------
Public Sub glDrawArraysInstancedBaseInstance(ByVal mode As Long, ByVal first As Long, ByVal count As Long, ByVal primcount As Long, ByVal baseinstance As Long): Call OpenGLExtCall5(glDrawArraysInstancedBaseInstancePtr, vbEmpty, mode, first, count, primcount, baseinstance): End Sub
Public Sub glDrawElementsInstancedBaseInstance(ByVal mode As Long, ByVal count As Long, ByVal ptype As Long, ByVal indices, ByVal primcount As Long, ByVal baseinstance As Long): Call OpenGLExtCall6(glDrawElementsInstancedBaseInstancePtr, vbEmpty, mode, count, ptype, indices, primcount, baseinstance): End Sub
Public Sub glDrawElementsInstancedBaseVertexBaseInstance(ByVal mode As Long, ByVal count As Long, ByVal ptype As Long, ByVal indices, ByVal primcount As Long, ByVal basevertex As Long, ByVal baseinstance As Long): Call OpenGLExtCall7(glDrawElementsInstancedBaseVertexBaseInstancePtr, vbEmpty, mode, count, ptype, indices, primcount, basevertex, baseinstance): End Sub
'------------------------------- GL_ARB_bindless_texture -------------------------------
Public Function glGetImageHandleARB(ByVal texture As Long, ByVal level As Long, ByVal layered As Integer, ByVal layer As Long, ByVal format As Long) As Currency: glGetImageHandleARB = OpenGLExtCall5(glGetImageHandleARBPtr, vbCurrency, texture, level, layered, layer, format): End Function
Public Function glGetTextureHandleARB(ByVal texture As Long) As Currency: glGetTextureHandleARB = OpenGLExtCall1(glGetTextureHandleARBPtr, vbCurrency, texture): End Function
Public Function glGetTextureSamplerHandleARB(ByVal texture As Long, ByVal sampler As Long) As Currency: glGetTextureSamplerHandleARB = OpenGLExtCall2(glGetTextureSamplerHandleARBPtr, vbCurrency, texture, sampler): End Function
Public Sub glGetVertexAttribLui64vARB(ByVal index As Long, ByVal pname As Long, params): Call OpenGLExtCall3(glGetVertexAttribLui64vARBPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Function glIsImageHandleResidentARB(ByVal handle As Currency) As Integer: glIsImageHandleResidentARB = OpenGLExtCall1(glIsImageHandleResidentARBPtr, vbInteger, handle): End Function
Public Function glIsTextureHandleResidentARB(ByVal handle As Currency) As Integer: glIsTextureHandleResidentARB = OpenGLExtCall1(glIsTextureHandleResidentARBPtr, vbInteger, handle): End Function
Public Sub glMakeImageHandleNonResidentARB(ByVal handle As Currency): Call OpenGLExtCall1(glMakeImageHandleNonResidentARBPtr, vbEmpty, handle): End Sub
Public Sub glMakeImageHandleResidentARB(ByVal handle As Currency, ByVal access As Long): Call OpenGLExtCall2(glMakeImageHandleResidentARBPtr, vbEmpty, handle, access): End Sub
Public Sub glMakeTextureHandleNonResidentARB(ByVal handle As Currency): Call OpenGLExtCall1(glMakeTextureHandleNonResidentARBPtr, vbEmpty, handle): End Sub
Public Sub glMakeTextureHandleResidentARB(ByVal handle As Currency): Call OpenGLExtCall1(glMakeTextureHandleResidentARBPtr, vbEmpty, handle): End Sub
Public Sub glProgramUniformHandleui64ARB(ByVal program As Long, ByVal location As Long, ByVal value As Currency): Call OpenGLExtCall3(glProgramUniformHandleui64ARBPtr, vbEmpty, program, location, value): End Sub
Public Sub glProgramUniformHandleui64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, values As Currency): Call OpenGLExtCall4(glProgramUniformHandleui64vARBPtr, vbEmpty, program, location, count, VarPtr(values)): End Sub
Public Sub glUniformHandleui64ARB(ByVal location As Long, ByVal value As Currency): Call OpenGLExtCall2(glUniformHandleui64ARBPtr, vbEmpty, location, value): End Sub
Public Sub glUniformHandleui64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniformHandleui64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glVertexAttribL1ui64ARB(ByVal index As Long, ByVal X): Call OpenGLExtCall2(glVertexAttribL1ui64ARBPtr, vbEmpty, index, X): End Sub
Public Sub glVertexAttribL1ui64vARB(ByVal index As Long, v): Call OpenGLExtCall2(glVertexAttribL1ui64vARBPtr, vbEmpty, index, VarPtr(v)): End Sub
'------------------------------- GL_ARB_blend_func_extended -------------------------------
Public Sub glBindFragDataLocationIndexed(ByVal program As Long, ByVal colorNumber As Long, ByVal index As Long, ByVal name): Call OpenGLExtCall4(glBindFragDataLocationIndexedPtr, vbEmpty, program, colorNumber, index, name): End Sub
Public Function glGetFragDataIndex(ByVal program As Long, ByVal name) As Long: glGetFragDataIndex = OpenGLExtCall2(glGetFragDataIndexPtr, vbLong, program, name): End Function
'------------------------------- GL_ARB_buffer_storage -------------------------------
Public Sub glBufferStorage(ByVal target As Long, ByVal size, ByVal data, ByVal flags As Long): Call OpenGLExtCall4(glBufferStoragePtr, vbEmpty, target, size, data, flags): End Sub
'------------------------------- GL_ARB_cl_event -------------------------------
Public Function glCreateSyncFromCLeventARB(ByVal context, ByVal pEvent, ByVal flags As Long) As Long: glCreateSyncFromCLeventARB = OpenGLExtCall3(glCreateSyncFromCLeventARBPtr, vbLong, context, pEvent, flags): End Function
'------------------------------- GL_ARB_clear_buffer_object -------------------------------
Public Sub glClearBufferData(ByVal target As Long, ByVal internalformat As Long, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall5(glClearBufferDataPtr, vbEmpty, target, internalformat, format, ptype, data): End Sub
Public Sub glClearBufferSubData(ByVal target As Long, ByVal internalformat As Long, ByVal offset, ByVal size, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall7(glClearBufferSubDataPtr, vbEmpty, target, internalformat, offset, size, format, ptype, data): End Sub
Public Sub glClearNamedBufferDataEXT(ByVal buffer As Long, ByVal internalformat As Long, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall5(glClearNamedBufferDataEXTPtr, vbEmpty, buffer, internalformat, format, ptype, data): End Sub
Public Sub glClearNamedBufferSubDataEXT(ByVal buffer As Long, ByVal internalformat As Long, ByVal offset, ByVal size, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall7(glClearNamedBufferSubDataEXTPtr, vbEmpty, buffer, internalformat, offset, size, format, ptype, data): End Sub
'------------------------------- GL_ARB_clear_texture -------------------------------
Public Sub glClearTexImage(ByVal texture As Long, ByVal level As Long, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall5(glClearTexImagePtr, vbEmpty, texture, level, format, ptype, data): End Sub
Public Sub glClearTexSubImage(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall11(glClearTexSubImagePtr, vbEmpty, texture, level, xoffset, yoffset, zoffset, Width, Height, depth, format, ptype, data): End Sub
'------------------------------- GL_ARB_clip_control -------------------------------
Public Sub glClipControl(ByVal origin As Long, ByVal depth As Long): Call OpenGLExtCall2(glClipControlPtr, vbEmpty, origin, depth): End Sub
'------------------------------- GL_ARB_color_buffer_float -------------------------------
Public Sub glClampColorARB(ByVal target As Long, ByVal clamp As Long): Call OpenGLExtCall2(glClampColorARBPtr, vbEmpty, target, clamp): End Sub
'------------------------------- GL_ARB_compatibility -------------------------------
'------------------------------- GL_ARB_compressed_texture_pixel_storage -------------------------------
'------------------------------- GL_ARB_compute_shader -------------------------------
Public Sub glDispatchCompute(ByVal num_groups_x As Long, ByVal num_groups_y As Long, ByVal num_groups_z As Long): Call OpenGLExtCall3(glDispatchComputePtr, vbEmpty, num_groups_x, num_groups_y, num_groups_z): End Sub
Public Sub glDispatchComputeIndirect(ByVal indirect): Call OpenGLExtCall1(glDispatchComputeIndirectPtr, vbEmpty, indirect): End Sub
'------------------------------- GL_ARB_compute_variable_group_size -------------------------------
Public Sub glDispatchComputeGroupSizeARB(ByVal num_groups_x As Long, ByVal num_groups_y As Long, ByVal num_groups_z As Long, ByVal group_size_x As Long, ByVal group_size_y As Long, ByVal group_size_z As Long): Call OpenGLExtCall6(glDispatchComputeGroupSizeARBPtr, vbEmpty, num_groups_x, num_groups_y, num_groups_z, group_size_x, group_size_y, group_size_z): End Sub
'------------------------------- GL_ARB_conditional_render_inverted -------------------------------
'------------------------------- GL_ARB_conservative_depth -------------------------------
'------------------------------- GL_ARB_copy_buffer -------------------------------
Public Sub glCopyBufferSubData(ByVal readtarget As Long, ByVal writetarget As Long, ByVal readOffset, ByVal writeOffset, ByVal size): Call OpenGLExtCall5(glCopyBufferSubDataPtr, vbEmpty, readtarget, writetarget, readOffset, writeOffset, size): End Sub
'------------------------------- GL_ARB_copy_image -------------------------------
Public Sub glCopyImageSubData(ByVal srcName As Long, ByVal srcTarget As Long, ByVal srcLevel As Long, ByVal srcX As Long, ByVal srcY As Long, ByVal srcZ As Long, ByVal dstName As Long, ByVal dstTarget As Long, ByVal dstLevel As Long, ByVal dstX As Long, ByVal dstY As Long, ByVal dstZ As Long, ByVal srcWidth As Long, ByVal srcHeight As Long, ByVal srcDepth As Long): Call OpenGLExtCall15(glCopyImageSubDataPtr, vbEmpty, srcName, srcTarget, srcLevel, srcX, srcY, srcZ, dstName, dstTarget, dstLevel, dstX, dstY, dstZ, srcWidth, srcHeight, srcDepth): End Sub
'------------------------------- GL_ARB_cull_distance -------------------------------
'------------------------------- GL_ARB_debug_output -------------------------------
Public Sub glDebugMessageCallbackARB(ByVal callback, ByVal userParam): Call OpenGLExtCall2(glDebugMessageCallbackARBPtr, vbEmpty, callback, userParam): End Sub
Public Sub glDebugMessageControlARB(ByVal source As Long, ByVal ptype As Long, ByVal severity As Long, ByVal count As Long, ids As Long, ByVal enabled As Integer): Call OpenGLExtCall6(glDebugMessageControlARBPtr, vbEmpty, source, ptype, severity, count, VarPtr(ids), enabled): End Sub
Public Sub glDebugMessageInsertARB(ByVal source As Long, ByVal ptype As Long, ByVal id As Long, ByVal severity As Long, ByVal length As Long, ByVal buf): Call OpenGLExtCall6(glDebugMessageInsertARBPtr, vbEmpty, source, ptype, id, severity, length, buf): End Sub
Public Function glGetDebugMessageLogARB(ByVal count As Long, ByVal bufSize As Long, sources As Long, types As Long, ids As Long, severities As Long, lengths As Long, ByVal messageLog) As Long: glGetDebugMessageLogARB = OpenGLExtCall8(glGetDebugMessageLogARBPtr, vbLong, count, bufSize, VarPtr(sources), VarPtr(types), VarPtr(ids), VarPtr(severities), VarPtr(lengths), messageLog): End Function
'------------------------------- GL_ARB_depth_buffer_float -------------------------------
'------------------------------- GL_ARB_depth_clamp -------------------------------
'------------------------------- GL_ARB_depth_texture -------------------------------
'------------------------------- GL_ARB_derivative_control -------------------------------
'------------------------------- GL_ARB_direct_state_access -------------------------------
Public Sub glBindTextureUnit(ByVal unit As Long, ByVal texture As Long): Call OpenGLExtCall2(glBindTextureUnitPtr, vbEmpty, unit, texture): End Sub
Public Sub glBlitNamedFramebuffer(ByVal readFramebuffer As Long, ByVal drawFramebuffer As Long, ByVal srcX0 As Long, ByVal srcY0 As Long, ByVal srcX1 As Long, ByVal srcY1 As Long, ByVal dstX0 As Long, ByVal dstY0 As Long, ByVal dstX1 As Long, ByVal dstY1 As Long, ByVal mask As Long, ByVal filter As Long): Call OpenGLExtCall12(glBlitNamedFramebufferPtr, vbEmpty, readFramebuffer, drawFramebuffer, srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter): End Sub
Public Function glCheckNamedFramebufferStatus(ByVal framebuffer As Long, ByVal target As Long) As Long: glCheckNamedFramebufferStatus = OpenGLExtCall2(glCheckNamedFramebufferStatusPtr, vbLong, framebuffer, target): End Function
Public Sub glClearNamedBufferData(ByVal buffer As Long, ByVal internalformat As Long, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall5(glClearNamedBufferDataPtr, vbEmpty, buffer, internalformat, format, ptype, data): End Sub
Public Sub glClearNamedBufferSubData(ByVal buffer As Long, ByVal internalformat As Long, ByVal offset, ByVal size, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall7(glClearNamedBufferSubDataPtr, vbEmpty, buffer, internalformat, offset, size, format, ptype, data): End Sub
Public Sub glClearNamedFramebufferfi(ByVal framebuffer As Long, ByVal buffer As Long, ByVal drawbuffer As Long, ByVal depth As Single, ByVal stencil As Long): Call OpenGLExtCall5(glClearNamedFramebufferfiPtr, vbEmpty, framebuffer, buffer, drawbuffer, depth, stencil): End Sub
Public Sub glClearNamedFramebufferfv(ByVal framebuffer As Long, ByVal buffer As Long, ByVal drawbuffer As Long, value As Single): Call OpenGLExtCall4(glClearNamedFramebufferfvPtr, vbEmpty, framebuffer, buffer, drawbuffer, VarPtr(value)): End Sub
Public Sub glClearNamedFramebufferiv(ByVal framebuffer As Long, ByVal buffer As Long, ByVal drawbuffer As Long, value As Long): Call OpenGLExtCall4(glClearNamedFramebufferivPtr, vbEmpty, framebuffer, buffer, drawbuffer, VarPtr(value)): End Sub
Public Sub glClearNamedFramebufferuiv(ByVal framebuffer As Long, ByVal buffer As Long, ByVal drawbuffer As Long, value As Long): Call OpenGLExtCall4(glClearNamedFramebufferuivPtr, vbEmpty, framebuffer, buffer, drawbuffer, VarPtr(value)): End Sub
Public Sub glCompressedTextureSubImage1D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal Width As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall7(glCompressedTextureSubImage1DPtr, vbEmpty, texture, level, xoffset, Width, format, imageSize, data): End Sub
Public Sub glCompressedTextureSubImage2D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall9(glCompressedTextureSubImage2DPtr, vbEmpty, texture, level, xoffset, yoffset, Width, Height, format, imageSize, data): End Sub
Public Sub glCompressedTextureSubImage3D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall11(glCompressedTextureSubImage3DPtr, vbEmpty, texture, level, xoffset, yoffset, zoffset, Width, Height, depth, format, imageSize, data): End Sub
Public Sub glCopyNamedBufferSubData(ByVal readBuffer As Long, ByVal writeBuffer As Long, ByVal readOffset, ByVal writeOffset, ByVal size): Call OpenGLExtCall5(glCopyNamedBufferSubDataPtr, vbEmpty, readBuffer, writeBuffer, readOffset, writeOffset, size): End Sub
Public Sub glCopyTextureSubImage1D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long): Call OpenGLExtCall6(glCopyTextureSubImage1DPtr, vbEmpty, texture, level, xoffset, X, y, Width): End Sub
Public Sub glCopyTextureSubImage2D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall8(glCopyTextureSubImage2DPtr, vbEmpty, texture, level, xoffset, yoffset, X, y, Width, Height): End Sub
Public Sub glCopyTextureSubImage3D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall9(glCopyTextureSubImage3DPtr, vbEmpty, texture, level, xoffset, yoffset, zoffset, X, y, Width, Height): End Sub
Public Sub glCreateBuffers(ByVal n As Long, buffers As Long): Call OpenGLExtCall2(glCreateBuffersPtr, vbEmpty, n, VarPtr(buffers)): End Sub
Public Sub glCreateFramebuffers(ByVal n As Long, framebuffers As Long): Call OpenGLExtCall2(glCreateFramebuffersPtr, vbEmpty, n, VarPtr(framebuffers)): End Sub
Public Sub glCreateProgramPipelines(ByVal n As Long, pipelines As Long): Call OpenGLExtCall2(glCreateProgramPipelinesPtr, vbEmpty, n, VarPtr(pipelines)): End Sub
Public Sub glCreateQueries(ByVal target As Long, ByVal n As Long, ids As Long): Call OpenGLExtCall3(glCreateQueriesPtr, vbEmpty, target, n, VarPtr(ids)): End Sub
Public Sub glCreateRenderbuffers(ByVal n As Long, renderbuffers As Long): Call OpenGLExtCall2(glCreateRenderbuffersPtr, vbEmpty, n, VarPtr(renderbuffers)): End Sub
Public Sub glCreateSamplers(ByVal n As Long, samplers As Long): Call OpenGLExtCall2(glCreateSamplersPtr, vbEmpty, n, VarPtr(samplers)): End Sub
Public Sub glCreateTextures(ByVal target As Long, ByVal n As Long, textures As Long): Call OpenGLExtCall3(glCreateTexturesPtr, vbEmpty, target, n, VarPtr(textures)): End Sub
Public Sub glCreateTransformFeedbacks(ByVal n As Long, ids As Long): Call OpenGLExtCall2(glCreateTransformFeedbacksPtr, vbEmpty, n, VarPtr(ids)): End Sub
Public Sub glCreateVertexArrays(ByVal n As Long, arrays As Long): Call OpenGLExtCall2(glCreateVertexArraysPtr, vbEmpty, n, VarPtr(arrays)): End Sub
Public Sub glDisableVertexArrayAttrib(ByVal vaobj As Long, ByVal index As Long): Call OpenGLExtCall2(glDisableVertexArrayAttribPtr, vbEmpty, vaobj, index): End Sub
Public Sub glEnableVertexArrayAttrib(ByVal vaobj As Long, ByVal index As Long): Call OpenGLExtCall2(glEnableVertexArrayAttribPtr, vbEmpty, vaobj, index): End Sub
Public Sub glFlushMappedNamedBufferRange(ByVal buffer As Long, ByVal offset, ByVal length): Call OpenGLExtCall3(glFlushMappedNamedBufferRangePtr, vbEmpty, buffer, offset, length): End Sub
Public Sub glGenerateTextureMipmap(ByVal texture As Long): Call OpenGLExtCall1(glGenerateTextureMipmapPtr, vbEmpty, texture): End Sub
Public Sub glGetCompressedTextureImage(ByVal texture As Long, ByVal level As Long, ByVal bufSize As Long, ByVal pixels): Call OpenGLExtCall4(glGetCompressedTextureImagePtr, vbEmpty, texture, level, bufSize, pixels): End Sub
Public Sub glGetNamedBufferParameteri64v(ByVal buffer As Long, ByVal pname As Long, params As Currency): Call OpenGLExtCall3(glGetNamedBufferParameteri64vPtr, vbEmpty, buffer, pname, VarPtr(params)): End Sub
Public Sub glGetNamedBufferParameteriv(ByVal buffer As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetNamedBufferParameterivPtr, vbEmpty, buffer, pname, VarPtr(params)): End Sub
Public Sub glGetNamedBufferPointerv(ByVal buffer As Long, ByVal pname As Long, ByVal params): Call OpenGLExtCall3(glGetNamedBufferPointervPtr, vbEmpty, buffer, pname, params): End Sub
Public Sub glGetNamedBufferSubData(ByVal buffer As Long, ByVal offset, ByVal size, ByVal data): Call OpenGLExtCall4(glGetNamedBufferSubDataPtr, vbEmpty, buffer, offset, size, data): End Sub
Public Sub glGetNamedFramebufferAttachmentParameteriv(ByVal framebuffer As Long, ByVal pattachment As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall4(glGetNamedFramebufferAttachmentParameterivPtr, vbEmpty, framebuffer, pattachment, pname, VarPtr(params)): End Sub
Public Sub glGetNamedFramebufferParameteriv(ByVal framebuffer As Long, ByVal pname As Long, param As Long): Call OpenGLExtCall3(glGetNamedFramebufferParameterivPtr, vbEmpty, framebuffer, pname, VarPtr(param)): End Sub
Public Sub glGetNamedRenderbufferParameteriv(ByVal renderbuffer As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetNamedRenderbufferParameterivPtr, vbEmpty, renderbuffer, pname, VarPtr(params)): End Sub
Public Sub glGetQueryBufferObjecti64v(ByVal id As Long, ByVal buffer As Long, ByVal pname As Long, ByVal offset): Call OpenGLExtCall4(glGetQueryBufferObjecti64vPtr, vbEmpty, id, buffer, pname, offset): End Sub
Public Sub glGetQueryBufferObjectiv(ByVal id As Long, ByVal buffer As Long, ByVal pname As Long, ByVal offset): Call OpenGLExtCall4(glGetQueryBufferObjectivPtr, vbEmpty, id, buffer, pname, offset): End Sub
Public Sub glGetQueryBufferObjectui64v(ByVal id As Long, ByVal buffer As Long, ByVal pname As Long, ByVal offset): Call OpenGLExtCall4(glGetQueryBufferObjectui64vPtr, vbEmpty, id, buffer, pname, offset): End Sub
Public Sub glGetQueryBufferObjectuiv(ByVal id As Long, ByVal buffer As Long, ByVal pname As Long, ByVal offset): Call OpenGLExtCall4(glGetQueryBufferObjectuivPtr, vbEmpty, id, buffer, pname, offset): End Sub
Public Sub glGetTextureImage(ByVal texture As Long, ByVal level As Long, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal pixels): Call OpenGLExtCall6(glGetTextureImagePtr, vbEmpty, texture, level, format, ptype, bufSize, pixels): End Sub
Public Sub glGetTextureLevelParameterfv(ByVal texture As Long, ByVal level As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall4(glGetTextureLevelParameterfvPtr, vbEmpty, texture, level, pname, VarPtr(params)): End Sub
Public Sub glGetTextureLevelParameteriv(ByVal texture As Long, ByVal level As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall4(glGetTextureLevelParameterivPtr, vbEmpty, texture, level, pname, VarPtr(params)): End Sub
Public Sub glGetTextureParameterIiv(ByVal texture As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetTextureParameterIivPtr, vbEmpty, texture, pname, VarPtr(params)): End Sub
Public Sub glGetTextureParameterIuiv(ByVal texture As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetTextureParameterIuivPtr, vbEmpty, texture, pname, VarPtr(params)): End Sub
Public Sub glGetTextureParameterfv(ByVal texture As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glGetTextureParameterfvPtr, vbEmpty, texture, pname, VarPtr(params)): End Sub
Public Sub glGetTextureParameteriv(ByVal texture As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetTextureParameterivPtr, vbEmpty, texture, pname, VarPtr(params)): End Sub
Public Sub glGetTransformFeedbacki64_v(ByVal xfb As Long, ByVal pname As Long, ByVal index As Long, param As Currency): Call OpenGLExtCall4(glGetTransformFeedbacki64_vPtr, vbEmpty, xfb, pname, index, VarPtr(param)): End Sub
Public Sub glGetTransformFeedbacki_v(ByVal xfb As Long, ByVal pname As Long, ByVal index As Long, param As Long): Call OpenGLExtCall4(glGetTransformFeedbacki_vPtr, vbEmpty, xfb, pname, index, VarPtr(param)): End Sub
Public Sub glGetTransformFeedbackiv(ByVal xfb As Long, ByVal pname As Long, param As Long): Call OpenGLExtCall3(glGetTransformFeedbackivPtr, vbEmpty, xfb, pname, VarPtr(param)): End Sub
Public Sub glGetVertexArrayIndexed64iv(ByVal vaobj As Long, ByVal index As Long, ByVal pname As Long, param As Currency): Call OpenGLExtCall4(glGetVertexArrayIndexed64ivPtr, vbEmpty, vaobj, index, pname, VarPtr(param)): End Sub
Public Sub glGetVertexArrayIndexediv(ByVal vaobj As Long, ByVal index As Long, ByVal pname As Long, param As Long): Call OpenGLExtCall4(glGetVertexArrayIndexedivPtr, vbEmpty, vaobj, index, pname, VarPtr(param)): End Sub
Public Sub glGetVertexArrayiv(ByVal vaobj As Long, ByVal pname As Long, param As Long): Call OpenGLExtCall3(glGetVertexArrayivPtr, vbEmpty, vaobj, pname, VarPtr(param)): End Sub
Public Sub glInvalidateNamedFramebufferData(ByVal framebuffer As Long, ByVal numAttachments As Long, attachments As Long): Call OpenGLExtCall3(glInvalidateNamedFramebufferDataPtr, vbEmpty, framebuffer, numAttachments, VarPtr(attachments)): End Sub
Public Sub glInvalidateNamedFramebufferSubData(ByVal framebuffer As Long, ByVal numAttachments As Long, attachments As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall7(glInvalidateNamedFramebufferSubDataPtr, vbEmpty, framebuffer, numAttachments, VarPtr(attachments), X, y, Width, Height): End Sub
Public Sub glNamedBufferData(ByVal buffer As Long, ByVal size, ByVal data, ByVal usage As Long): Call OpenGLExtCall4(glNamedBufferDataPtr, vbEmpty, buffer, size, data, usage): End Sub
Public Sub glNamedBufferStorage(ByVal buffer As Long, ByVal size, ByVal data, ByVal flags As Long): Call OpenGLExtCall4(glNamedBufferStoragePtr, vbEmpty, buffer, size, data, flags): End Sub
Public Sub glNamedBufferSubData(ByVal buffer As Long, ByVal offset, ByVal size, ByVal data): Call OpenGLExtCall4(glNamedBufferSubDataPtr, vbEmpty, buffer, offset, size, data): End Sub
Public Sub glNamedFramebufferDrawBuffer(ByVal framebuffer As Long, ByVal mode As Long): Call OpenGLExtCall2(glNamedFramebufferDrawBufferPtr, vbEmpty, framebuffer, mode): End Sub
Public Sub glNamedFramebufferDrawBuffers(ByVal framebuffer As Long, ByVal n As Long, bufs As Long): Call OpenGLExtCall3(glNamedFramebufferDrawBuffersPtr, vbEmpty, framebuffer, n, VarPtr(bufs)): End Sub
Public Sub glNamedFramebufferParameteri(ByVal framebuffer As Long, ByVal pname As Long, ByVal param As Long): Call OpenGLExtCall3(glNamedFramebufferParameteriPtr, vbEmpty, framebuffer, pname, param): End Sub
Public Sub glNamedFramebufferReadBuffer(ByVal framebuffer As Long, ByVal mode As Long): Call OpenGLExtCall2(glNamedFramebufferReadBufferPtr, vbEmpty, framebuffer, mode): End Sub
Public Sub glNamedFramebufferRenderbuffer(ByVal framebuffer As Long, ByVal pattachment As Long, ByVal renderbuffertarget As Long, ByVal renderbuffer As Long): Call OpenGLExtCall4(glNamedFramebufferRenderbufferPtr, vbEmpty, framebuffer, pattachment, renderbuffertarget, renderbuffer): End Sub
Public Sub glNamedFramebufferTexture(ByVal framebuffer As Long, ByVal pattachment As Long, ByVal texture As Long, ByVal level As Long): Call OpenGLExtCall4(glNamedFramebufferTexturePtr, vbEmpty, framebuffer, pattachment, texture, level): End Sub
Public Sub glNamedFramebufferTextureLayer(ByVal framebuffer As Long, ByVal pattachment As Long, ByVal texture As Long, ByVal level As Long, ByVal layer As Long): Call OpenGLExtCall5(glNamedFramebufferTextureLayerPtr, vbEmpty, framebuffer, pattachment, texture, level, layer): End Sub
Public Sub glNamedRenderbufferStorage(ByVal renderbuffer As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall4(glNamedRenderbufferStoragePtr, vbEmpty, renderbuffer, internalformat, Width, Height): End Sub
Public Sub glNamedRenderbufferStorageMultisample(ByVal renderbuffer As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall5(glNamedRenderbufferStorageMultisamplePtr, vbEmpty, renderbuffer, samples, internalformat, Width, Height): End Sub
Public Sub glTextureBuffer(ByVal texture As Long, ByVal internalformat As Long, ByVal buffer As Long): Call OpenGLExtCall3(glTextureBufferPtr, vbEmpty, texture, internalformat, buffer): End Sub
Public Sub glTextureBufferRange(ByVal texture As Long, ByVal internalformat As Long, ByVal buffer As Long, ByVal offset, ByVal size): Call OpenGLExtCall5(glTextureBufferRangePtr, vbEmpty, texture, internalformat, buffer, offset, size): End Sub
Public Sub glTextureParameterIiv(ByVal texture As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glTextureParameterIivPtr, vbEmpty, texture, pname, VarPtr(params)): End Sub
Public Sub glTextureParameterIuiv(ByVal texture As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glTextureParameterIuivPtr, vbEmpty, texture, pname, VarPtr(params)): End Sub
Public Sub glTextureParameterf(ByVal texture As Long, ByVal pname As Long, ByVal param As Single): Call OpenGLExtCall3(glTextureParameterfPtr, vbEmpty, texture, pname, param): End Sub
Public Sub glTextureParameterfv(ByVal texture As Long, ByVal pname As Long, param As Single): Call OpenGLExtCall3(glTextureParameterfvPtr, vbEmpty, texture, pname, VarPtr(param)): End Sub
Public Sub glTextureParameteri(ByVal texture As Long, ByVal pname As Long, ByVal param As Long): Call OpenGLExtCall3(glTextureParameteriPtr, vbEmpty, texture, pname, param): End Sub
Public Sub glTextureParameteriv(ByVal texture As Long, ByVal pname As Long, param As Long): Call OpenGLExtCall3(glTextureParameterivPtr, vbEmpty, texture, pname, VarPtr(param)): End Sub
Public Sub glTextureStorage1D(ByVal texture As Long, ByVal levels As Long, ByVal internalformat As Long, ByVal Width As Long): Call OpenGLExtCall4(glTextureStorage1DPtr, vbEmpty, texture, levels, internalformat, Width): End Sub
Public Sub glTextureStorage2D(ByVal texture As Long, ByVal levels As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall5(glTextureStorage2DPtr, vbEmpty, texture, levels, internalformat, Width, Height): End Sub
Public Sub glTextureStorage2DMultisample(ByVal texture As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal fixedSampleLocations As Integer): Call OpenGLExtCall6(glTextureStorage2DMultisamplePtr, vbEmpty, texture, samples, internalformat, Width, Height, fixedSampleLocations): End Sub
Public Sub glTextureStorage3D(ByVal texture As Long, ByVal levels As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long): Call OpenGLExtCall6(glTextureStorage3DPtr, vbEmpty, texture, levels, internalformat, Width, Height, depth): End Sub
Public Sub glTextureStorage3DMultisample(ByVal texture As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal fixedSampleLocations As Integer): Call OpenGLExtCall7(glTextureStorage3DMultisamplePtr, vbEmpty, texture, samples, internalformat, Width, Height, depth, fixedSampleLocations): End Sub
Public Sub glTextureSubImage1D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal Width As Long, ByVal format As Long, ByVal ptype As Long, ByVal pixels): Call OpenGLExtCall7(glTextureSubImage1DPtr, vbEmpty, texture, level, xoffset, Width, format, ptype, pixels): End Sub
Public Sub glTextureSubImage2D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal ptype As Long, ByVal pixels): Call OpenGLExtCall9(glTextureSubImage2DPtr, vbEmpty, texture, level, xoffset, yoffset, Width, Height, format, ptype, pixels): End Sub
Public Sub glTextureSubImage3D(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal format As Long, ByVal ptype As Long, ByVal pixels): Call OpenGLExtCall11(glTextureSubImage3DPtr, vbEmpty, texture, level, xoffset, yoffset, zoffset, Width, Height, depth, format, ptype, pixels): End Sub
Public Sub glTransformFeedbackBufferBase(ByVal xfb As Long, ByVal index As Long, ByVal buffer As Long): Call OpenGLExtCall3(glTransformFeedbackBufferBasePtr, vbEmpty, xfb, index, buffer): End Sub
Public Sub glTransformFeedbackBufferRange(ByVal xfb As Long, ByVal index As Long, ByVal buffer As Long, ByVal offset, ByVal size): Call OpenGLExtCall5(glTransformFeedbackBufferRangePtr, vbEmpty, xfb, index, buffer, offset, size): End Sub
Public Function glUnmapNamedBuffer(ByVal buffer As Long) As Integer: glUnmapNamedBuffer = OpenGLExtCall1(glUnmapNamedBufferPtr, vbInteger, buffer): End Function
Public Sub glVertexArrayAttribBinding(ByVal vaobj As Long, ByVal attribindex As Long, ByVal bindingindex As Long): Call OpenGLExtCall3(glVertexArrayAttribBindingPtr, vbEmpty, vaobj, attribindex, bindingindex): End Sub
Public Sub glVertexArrayAttribFormat(ByVal vaobj As Long, ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal relativeoffset As Long): Call OpenGLExtCall6(glVertexArrayAttribFormatPtr, vbEmpty, vaobj, attribindex, size, ptype, normalized, relativeoffset): End Sub
Public Sub glVertexArrayAttribIFormat(ByVal vaobj As Long, ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal relativeoffset As Long): Call OpenGLExtCall5(glVertexArrayAttribIFormatPtr, vbEmpty, vaobj, attribindex, size, ptype, relativeoffset): End Sub
Public Sub glVertexArrayAttribLFormat(ByVal vaobj As Long, ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal relativeoffset As Long): Call OpenGLExtCall5(glVertexArrayAttribLFormatPtr, vbEmpty, vaobj, attribindex, size, ptype, relativeoffset): End Sub
Public Sub glVertexArrayBindingDivisor(ByVal vaobj As Long, ByVal bindingindex As Long, ByVal divisor As Long): Call OpenGLExtCall3(glVertexArrayBindingDivisorPtr, vbEmpty, vaobj, bindingindex, divisor): End Sub
Public Sub glVertexArrayElementBuffer(ByVal vaobj As Long, ByVal buffer As Long): Call OpenGLExtCall2(glVertexArrayElementBufferPtr, vbEmpty, vaobj, buffer): End Sub
Public Sub glVertexArrayVertexBuffer(ByVal vaobj As Long, ByVal bindingindex As Long, ByVal buffer As Long, ByVal offset, ByVal stride As Long): Call OpenGLExtCall5(glVertexArrayVertexBufferPtr, vbEmpty, vaobj, bindingindex, buffer, offset, stride): End Sub
Public Sub glVertexArrayVertexBuffers(ByVal vaobj As Long, ByVal first As Long, ByVal count As Long, buffers As Long, offsets, strides As Long): Call OpenGLExtCall6(glVertexArrayVertexBuffersPtr, vbEmpty, vaobj, first, count, VarPtr(buffers), VarPtr(offsets), VarPtr(strides)): End Sub
'------------------------------- GL_ARB_draw_buffers -------------------------------
Public Sub glDrawBuffersARB(ByVal n As Long, bufs As Long): Call OpenGLExtCall2(glDrawBuffersARBPtr, vbEmpty, n, VarPtr(bufs)): End Sub
'------------------------------- GL_ARB_draw_buffers_blend -------------------------------
Public Sub glBlendEquationSeparateiARB(ByVal buf As Long, ByVal modeRGB As Long, ByVal modeAlpha As Long): Call OpenGLExtCall3(glBlendEquationSeparateiARBPtr, vbEmpty, buf, modeRGB, modeAlpha): End Sub
Public Sub glBlendEquationiARB(ByVal buf As Long, ByVal mode As Long): Call OpenGLExtCall2(glBlendEquationiARBPtr, vbEmpty, buf, mode): End Sub
Public Sub glBlendFuncSeparateiARB(ByVal buf As Long, ByVal srcRGB As Long, ByVal dstRGB As Long, ByVal srcAlpha As Long, ByVal dstAlpha As Long): Call OpenGLExtCall5(glBlendFuncSeparateiARBPtr, vbEmpty, buf, srcRGB, dstRGB, srcAlpha, dstAlpha): End Sub
Public Sub glBlendFunciARB(ByVal buf As Long, ByVal src As Long, ByVal dst As Long): Call OpenGLExtCall3(glBlendFunciARBPtr, vbEmpty, buf, src, dst): End Sub
'------------------------------- GL_ARB_draw_elements_base_vertex -------------------------------
Public Sub glDrawElementsBaseVertex(ByVal mode As Long, ByVal count As Long, ByVal ptype As Long, ByVal indices, ByVal basevertex As Long): Call OpenGLExtCall5(glDrawElementsBaseVertexPtr, vbEmpty, mode, count, ptype, indices, basevertex): End Sub
Public Sub glDrawElementsInstancedBaseVertex(ByVal mode As Long, ByVal count As Long, ByVal ptype As Long, ByVal indices, ByVal primcount As Long, ByVal basevertex As Long): Call OpenGLExtCall6(glDrawElementsInstancedBaseVertexPtr, vbEmpty, mode, count, ptype, indices, primcount, basevertex): End Sub
Public Sub glDrawRangeElementsBaseVertex(ByVal mode As Long, ByVal start As Long, ByVal pend As Long, ByVal count As Long, ByVal ptype As Long, ByVal indices, ByVal basevertex As Long): Call OpenGLExtCall7(glDrawRangeElementsBaseVertexPtr, vbEmpty, mode, start, pend, count, ptype, indices, basevertex): End Sub
Public Sub glMultiDrawElementsBaseVertex(ByVal mode As Long, count As Long, ByVal ptype As Long, ByVal indices, ByVal primcount As Long, basevertex As Long): Call OpenGLExtCall6(glMultiDrawElementsBaseVertexPtr, vbEmpty, mode, VarPtr(count), ptype, indices, primcount, VarPtr(basevertex)): End Sub
'------------------------------- GL_ARB_draw_indirect -------------------------------
Public Sub glDrawArraysIndirect(ByVal mode As Long, ByVal indirect): Call OpenGLExtCall2(glDrawArraysIndirectPtr, vbEmpty, mode, indirect): End Sub
Public Sub glDrawElementsIndirect(ByVal mode As Long, ByVal ptype As Long, ByVal indirect): Call OpenGLExtCall3(glDrawElementsIndirectPtr, vbEmpty, mode, ptype, indirect): End Sub
'------------------------------- GL_ARB_draw_instanced -------------------------------
'------------------------------- GL_ARB_enhanced_layouts -------------------------------
'------------------------------- GL_ARB_explicit_attrib_location -------------------------------
'------------------------------- GL_ARB_explicit_uniform_location -------------------------------
'------------------------------- GL_ARB_fragment_coord_conventions -------------------------------
'------------------------------- GL_ARB_fragment_layer_viewport -------------------------------
'------------------------------- GL_ARB_fragment_program -------------------------------
'------------------------------- GL_ARB_fragment_program_shadow -------------------------------
'------------------------------- GL_ARB_fragment_shader -------------------------------
'------------------------------- GL_ARB_fragment_shader_interlock -------------------------------
'------------------------------- GL_ARB_framebuffer_no_attachments -------------------------------
Public Sub glFramebufferParameteri(ByVal target As Long, ByVal pname As Long, ByVal param As Long): Call OpenGLExtCall3(glFramebufferParameteriPtr, vbEmpty, target, pname, param): End Sub
Public Sub glGetFramebufferParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetFramebufferParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetNamedFramebufferParameterivEXT(ByVal framebuffer As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetNamedFramebufferParameterivEXTPtr, vbEmpty, framebuffer, pname, VarPtr(params)): End Sub
Public Sub glNamedFramebufferParameteriEXT(ByVal framebuffer As Long, ByVal pname As Long, ByVal param As Long): Call OpenGLExtCall3(glNamedFramebufferParameteriEXTPtr, vbEmpty, framebuffer, pname, param): End Sub
'------------------------------- GL_ARB_framebuffer_object -------------------------------
Public Sub glBindFramebuffer(ByVal target As Long, ByVal framebuffer As Long): Call OpenGLExtCall2(glBindFramebufferPtr, vbEmpty, target, framebuffer): End Sub
Public Sub glBindRenderbuffer(ByVal target As Long, ByVal renderbuffer As Long): Call OpenGLExtCall2(glBindRenderbufferPtr, vbEmpty, target, renderbuffer): End Sub
Public Sub glBlitFramebuffer(ByVal srcX0 As Long, ByVal srcY0 As Long, ByVal srcX1 As Long, ByVal srcY1 As Long, ByVal dstX0 As Long, ByVal dstY0 As Long, ByVal dstX1 As Long, ByVal dstY1 As Long, ByVal mask As Long, ByVal filter As Long): Call OpenGLExtCall10(glBlitFramebufferPtr, vbEmpty, srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, mask, filter): End Sub
Public Function glCheckFramebufferStatus(ByVal target As Long) As Long: glCheckFramebufferStatus = OpenGLExtCall1(glCheckFramebufferStatusPtr, vbLong, target): End Function
Public Sub glDeleteFramebuffers(ByVal n As Long, framebuffers As Long): Call OpenGLExtCall2(glDeleteFramebuffersPtr, vbEmpty, n, VarPtr(framebuffers)): End Sub
Public Sub glDeleteRenderbuffers(ByVal n As Long, renderbuffers As Long): Call OpenGLExtCall2(glDeleteRenderbuffersPtr, vbEmpty, n, VarPtr(renderbuffers)): End Sub
Public Sub glFramebufferRenderbuffer(ByVal target As Long, ByVal pattachment As Long, ByVal renderbuffertarget As Long, ByVal renderbuffer As Long): Call OpenGLExtCall4(glFramebufferRenderbufferPtr, vbEmpty, target, pattachment, renderbuffertarget, renderbuffer): End Sub
Public Sub glFramebufferTexture1D(ByVal target As Long, ByVal pattachment As Long, ByVal textarget As Long, ByVal texture As Long, ByVal level As Long): Call OpenGLExtCall5(glFramebufferTexture1DPtr, vbEmpty, target, pattachment, textarget, texture, level): End Sub
Public Sub glFramebufferTexture2D(ByVal target As Long, ByVal pattachment As Long, ByVal textarget As Long, ByVal texture As Long, ByVal level As Long): Call OpenGLExtCall5(glFramebufferTexture2DPtr, vbEmpty, target, pattachment, textarget, texture, level): End Sub
Public Sub glFramebufferTexture3D(ByVal target As Long, ByVal pattachment As Long, ByVal textarget As Long, ByVal texture As Long, ByVal level As Long, ByVal layer As Long): Call OpenGLExtCall6(glFramebufferTexture3DPtr, vbEmpty, target, pattachment, textarget, texture, level, layer): End Sub
Public Sub glFramebufferTextureLayer(ByVal target As Long, ByVal pattachment As Long, ByVal texture As Long, ByVal level As Long, ByVal layer As Long): Call OpenGLExtCall5(glFramebufferTextureLayerPtr, vbEmpty, target, pattachment, texture, level, layer): End Sub
Public Sub glGenFramebuffers(ByVal n As Long, framebuffers As Long): Call OpenGLExtCall2(glGenFramebuffersPtr, vbEmpty, n, VarPtr(framebuffers)): End Sub
Public Sub glGenRenderbuffers(ByVal n As Long, renderbuffers As Long): Call OpenGLExtCall2(glGenRenderbuffersPtr, vbEmpty, n, VarPtr(renderbuffers)): End Sub
Public Sub glGenerateMipmap(ByVal target As Long): Call OpenGLExtCall1(glGenerateMipmapPtr, vbEmpty, target): End Sub
Public Sub glGetFramebufferAttachmentParameteriv(ByVal target As Long, ByVal pattachment As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall4(glGetFramebufferAttachmentParameterivPtr, vbEmpty, target, pattachment, pname, VarPtr(params)): End Sub
Public Sub glGetRenderbufferParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetRenderbufferParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Function glIsFramebuffer(ByVal framebuffer As Long) As Integer: glIsFramebuffer = OpenGLExtCall1(glIsFramebufferPtr, vbInteger, framebuffer): End Function
Public Function glIsRenderbuffer(ByVal renderbuffer As Long) As Integer: glIsRenderbuffer = OpenGLExtCall1(glIsRenderbufferPtr, vbInteger, renderbuffer): End Function
Public Sub glRenderbufferStorage(ByVal target As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall4(glRenderbufferStoragePtr, vbEmpty, target, internalformat, Width, Height): End Sub
Public Sub glRenderbufferStorageMultisample(ByVal target As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall5(glRenderbufferStorageMultisamplePtr, vbEmpty, target, samples, internalformat, Width, Height): End Sub
'------------------------------- GL_ARB_framebuffer_sRGB -------------------------------
'------------------------------- GL_ARB_geometry_shader4 -------------------------------
Public Sub glFramebufferTextureARB(ByVal target As Long, ByVal pattachment As Long, ByVal texture As Long, ByVal level As Long): Call OpenGLExtCall4(glFramebufferTextureARBPtr, vbEmpty, target, pattachment, texture, level): End Sub
Public Sub glFramebufferTextureFaceARB(ByVal target As Long, ByVal pattachment As Long, ByVal texture As Long, ByVal level As Long, ByVal face As Long): Call OpenGLExtCall5(glFramebufferTextureFaceARBPtr, vbEmpty, target, pattachment, texture, level, face): End Sub
Public Sub glFramebufferTextureLayerARB(ByVal target As Long, ByVal pattachment As Long, ByVal texture As Long, ByVal level As Long, ByVal layer As Long): Call OpenGLExtCall5(glFramebufferTextureLayerARBPtr, vbEmpty, target, pattachment, texture, level, layer): End Sub
Public Sub glProgramParameteriARB(ByVal program As Long, ByVal pname As Long, ByVal value As Long): Call OpenGLExtCall3(glProgramParameteriARBPtr, vbEmpty, program, pname, value): End Sub
'------------------------------- GL_ARB_get_program_binary -------------------------------
Public Sub glGetProgramBinary(ByVal program As Long, ByVal bufSize As Long, length As Long, binaryFormat As Long, ByVal binary): Call OpenGLExtCall5(glGetProgramBinaryPtr, vbEmpty, program, bufSize, VarPtr(length), VarPtr(binaryFormat), binary): End Sub
Public Sub glProgramBinary(ByVal program As Long, ByVal binaryFormat As Long, ByVal binary, ByVal length As Long): Call OpenGLExtCall4(glProgramBinaryPtr, vbEmpty, program, binaryFormat, binary, length): End Sub
Public Sub glProgramParameteri(ByVal program As Long, ByVal pname As Long, ByVal value As Long): Call OpenGLExtCall3(glProgramParameteriPtr, vbEmpty, program, pname, value): End Sub
'------------------------------- GL_ARB_get_texture_sub_image -------------------------------
Public Sub glGetCompressedTextureSubImage(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal bufSize As Long, ByVal pixels): Call OpenGLExtCall10(glGetCompressedTextureSubImagePtr, vbEmpty, texture, level, xoffset, yoffset, zoffset, Width, Height, depth, bufSize, pixels): End Sub
Public Sub glGetTextureSubImage(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal pixels): Call OpenGLExtCall12(glGetTextureSubImagePtr, vbEmpty, texture, level, xoffset, yoffset, zoffset, Width, Height, depth, format, ptype, bufSize, pixels): End Sub
'------------------------------- GL_ARB_gl_spirv -------------------------------
Public Sub glSpecializeShaderARB(ByVal shader As Long, ByVal pEntryPoint, ByVal numSpecializationConstants As Long, pConstantIndex As Long, pConstantValue As Long): Call OpenGLExtCall5(glSpecializeShaderARBPtr, vbEmpty, shader, pEntryPoint, numSpecializationConstants, VarPtr(pConstantIndex), VarPtr(pConstantValue)): End Sub
'------------------------------- GL_ARB_gpu_shader5 -------------------------------
'------------------------------- GL_ARB_gpu_shader_fp64 -------------------------------
Public Sub glGetUniformdv(ByVal program As Long, ByVal location As Long, params As Double): Call OpenGLExtCall3(glGetUniformdvPtr, vbEmpty, program, location, VarPtr(params)): End Sub
Public Sub glUniform1d(ByVal location As Long, ByVal X As Double): Call OpenGLExtCall2(glUniform1dPtr, vbEmpty, location, X): End Sub
Public Sub glUniform1dv(ByVal location As Long, ByVal count As Long, value As Double): Call OpenGLExtCall3(glUniform1dvPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform2d(ByVal location As Long, ByVal X As Double, ByVal y As Double): Call OpenGLExtCall3(glUniform2dPtr, vbEmpty, location, X, y): End Sub
Public Sub glUniform2dv(ByVal location As Long, ByVal count As Long, value As Double): Call OpenGLExtCall3(glUniform2dvPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform3d(ByVal location As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double): Call OpenGLExtCall4(glUniform3dPtr, vbEmpty, location, X, y, z): End Sub
Public Sub glUniform3dv(ByVal location As Long, ByVal count As Long, value As Double): Call OpenGLExtCall3(glUniform3dvPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform4d(ByVal location As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double, ByVal w As Double): Call OpenGLExtCall5(glUniform4dPtr, vbEmpty, location, X, y, z, w): End Sub
Public Sub glUniform4dv(ByVal location As Long, ByVal count As Long, value As Double): Call OpenGLExtCall3(glUniform4dvPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniformMatrix2dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix2dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix2x3dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix2x3dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix2x4dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix2x4dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix3dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix3dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix3x2dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix3x2dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix3x4dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix3x4dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix4dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix4dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix4x2dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix4x2dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix4x3dv(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall4(glUniformMatrix4x3dvPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
'------------------------------- GL_ARB_gpu_shader_int64 -------------------------------
Public Sub glGetUniformi64vARB(ByVal program As Long, ByVal location As Long, params As Currency): Call OpenGLExtCall3(glGetUniformi64vARBPtr, vbEmpty, program, location, VarPtr(params)): End Sub
Public Sub glGetUniformui64vARB(ByVal program As Long, ByVal location As Long, params As Currency): Call OpenGLExtCall3(glGetUniformui64vARBPtr, vbEmpty, program, location, VarPtr(params)): End Sub
Public Sub glGetnUniformi64vARB(ByVal program As Long, ByVal location As Long, ByVal bufSize As Long, params As Currency): Call OpenGLExtCall4(glGetnUniformi64vARBPtr, vbEmpty, program, location, bufSize, VarPtr(params)): End Sub
Public Sub glGetnUniformui64vARB(ByVal program As Long, ByVal location As Long, ByVal bufSize As Long, params As Currency): Call OpenGLExtCall4(glGetnUniformui64vARBPtr, vbEmpty, program, location, bufSize, VarPtr(params)): End Sub
Public Sub glProgramUniform1i64ARB(ByVal program As Long, ByVal location As Long, ByVal X As Currency): Call OpenGLExtCall3(glProgramUniform1i64ARBPtr, vbEmpty, program, location, X): End Sub
Public Sub glProgramUniform1i64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall4(glProgramUniform1i64vARBPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform1ui64ARB(ByVal program As Long, ByVal location As Long, ByVal X As Currency): Call OpenGLExtCall3(glProgramUniform1ui64ARBPtr, vbEmpty, program, location, X): End Sub
Public Sub glProgramUniform1ui64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall4(glProgramUniform1ui64vARBPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform2i64ARB(ByVal program As Long, ByVal location As Long, ByVal X As Currency, ByVal y As Currency): Call OpenGLExtCall4(glProgramUniform2i64ARBPtr, vbEmpty, program, location, X, y): End Sub
Public Sub glProgramUniform2i64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall4(glProgramUniform2i64vARBPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform2ui64ARB(ByVal program As Long, ByVal location As Long, ByVal X As Currency, ByVal y As Currency): Call OpenGLExtCall4(glProgramUniform2ui64ARBPtr, vbEmpty, program, location, X, y): End Sub
Public Sub glProgramUniform2ui64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall4(glProgramUniform2ui64vARBPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform3i64ARB(ByVal program As Long, ByVal location As Long, ByVal X As Currency, ByVal y As Currency, ByVal z As Currency): Call OpenGLExtCall5(glProgramUniform3i64ARBPtr, vbEmpty, program, location, X, y, z): End Sub
Public Sub glProgramUniform3i64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall4(glProgramUniform3i64vARBPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform3ui64ARB(ByVal program As Long, ByVal location As Long, ByVal X As Currency, ByVal y As Currency, ByVal z As Currency): Call OpenGLExtCall5(glProgramUniform3ui64ARBPtr, vbEmpty, program, location, X, y, z): End Sub
Public Sub glProgramUniform3ui64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall4(glProgramUniform3ui64vARBPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform4i64ARB(ByVal program As Long, ByVal location As Long, ByVal X As Currency, ByVal y As Currency, ByVal z As Currency, ByVal w As Currency): Call OpenGLExtCall6(glProgramUniform4i64ARBPtr, vbEmpty, program, location, X, y, z, w): End Sub
Public Sub glProgramUniform4i64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall4(glProgramUniform4i64vARBPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform4ui64ARB(ByVal program As Long, ByVal location As Long, ByVal X As Currency, ByVal y As Currency, ByVal z As Currency, ByVal w As Currency): Call OpenGLExtCall6(glProgramUniform4ui64ARBPtr, vbEmpty, program, location, X, y, z, w): End Sub
Public Sub glProgramUniform4ui64vARB(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall4(glProgramUniform4ui64vARBPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glUniform1i64ARB(ByVal location As Long, ByVal X As Currency): Call OpenGLExtCall2(glUniform1i64ARBPtr, vbEmpty, location, X): End Sub
Public Sub glUniform1i64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniform1i64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform1ui64ARB(ByVal location As Long, ByVal X As Currency): Call OpenGLExtCall2(glUniform1ui64ARBPtr, vbEmpty, location, X): End Sub
Public Sub glUniform1ui64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniform1ui64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform2i64ARB(ByVal location As Long, ByVal X As Currency, ByVal y As Currency): Call OpenGLExtCall3(glUniform2i64ARBPtr, vbEmpty, location, X, y): End Sub
Public Sub glUniform2i64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniform2i64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform2ui64ARB(ByVal location As Long, ByVal X As Currency, ByVal y As Currency): Call OpenGLExtCall3(glUniform2ui64ARBPtr, vbEmpty, location, X, y): End Sub
Public Sub glUniform2ui64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniform2ui64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform3i64ARB(ByVal location As Long, ByVal X As Currency, ByVal y As Currency, ByVal z As Currency): Call OpenGLExtCall4(glUniform3i64ARBPtr, vbEmpty, location, X, y, z): End Sub
Public Sub glUniform3i64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniform3i64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform3ui64ARB(ByVal location As Long, ByVal X As Currency, ByVal y As Currency, ByVal z As Currency): Call OpenGLExtCall4(glUniform3ui64ARBPtr, vbEmpty, location, X, y, z): End Sub
Public Sub glUniform3ui64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniform3ui64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform4i64ARB(ByVal location As Long, ByVal X As Currency, ByVal y As Currency, ByVal z As Currency, ByVal w As Currency): Call OpenGLExtCall5(glUniform4i64ARBPtr, vbEmpty, location, X, y, z, w): End Sub
Public Sub glUniform4i64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniform4i64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform4ui64ARB(ByVal location As Long, ByVal X As Currency, ByVal y As Currency, ByVal z As Currency, ByVal w As Currency): Call OpenGLExtCall5(glUniform4ui64ARBPtr, vbEmpty, location, X, y, z, w): End Sub
Public Sub glUniform4ui64vARB(ByVal location As Long, ByVal count As Long, value As Currency): Call OpenGLExtCall3(glUniform4ui64vARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
'------------------------------- GL_ARB_half_float_pixel -------------------------------
'------------------------------- GL_ARB_half_float_vertex -------------------------------
'------------------------------- GL_ARB_imaging -------------------------------
Public Sub glColorSubTable(ByVal target As Long, ByVal start As Long, ByVal count As Long, ByVal format As Long, ByVal ptype As Long, ByVal data): Call OpenGLExtCall6(glColorSubTablePtr, vbEmpty, target, start, count, format, ptype, data): End Sub
Public Sub glColorTable(ByVal target As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal format As Long, ByVal ptype As Long, ByVal table): Call OpenGLExtCall6(glColorTablePtr, vbEmpty, target, internalformat, Width, format, ptype, table): End Sub
Public Sub glColorTableParameterfv(ByVal target As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glColorTableParameterfvPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glColorTableParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glColorTableParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glConvolutionFilter1D(ByVal target As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal format As Long, ByVal ptype As Long, ByVal Image): Call OpenGLExtCall6(glConvolutionFilter1DPtr, vbEmpty, target, internalformat, Width, format, ptype, Image): End Sub
Public Sub glConvolutionFilter2D(ByVal target As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal ptype As Long, ByVal Image): Call OpenGLExtCall7(glConvolutionFilter2DPtr, vbEmpty, target, internalformat, Width, Height, format, ptype, Image): End Sub
Public Sub glConvolutionParameterf(ByVal target As Long, ByVal pname As Long, ByVal params As Single): Call OpenGLExtCall3(glConvolutionParameterfPtr, vbEmpty, target, pname, params): End Sub
Public Sub glConvolutionParameterfv(ByVal target As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glConvolutionParameterfvPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glConvolutionParameteri(ByVal target As Long, ByVal pname As Long, ByVal params As Long): Call OpenGLExtCall3(glConvolutionParameteriPtr, vbEmpty, target, pname, params): End Sub
Public Sub glConvolutionParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glConvolutionParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glCopyColorSubTable(ByVal target As Long, ByVal start As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long): Call OpenGLExtCall5(glCopyColorSubTablePtr, vbEmpty, target, start, X, y, Width): End Sub
Public Sub glCopyColorTable(ByVal target As Long, ByVal internalformat As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long): Call OpenGLExtCall5(glCopyColorTablePtr, vbEmpty, target, internalformat, X, y, Width): End Sub
Public Sub glCopyConvolutionFilter1D(ByVal target As Long, ByVal internalformat As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long): Call OpenGLExtCall5(glCopyConvolutionFilter1DPtr, vbEmpty, target, internalformat, X, y, Width): End Sub
Public Sub glCopyConvolutionFilter2D(ByVal target As Long, ByVal internalformat As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall6(glCopyConvolutionFilter2DPtr, vbEmpty, target, internalformat, X, y, Width, Height): End Sub
Public Sub glGetColorTable(ByVal target As Long, ByVal format As Long, ByVal ptype As Long, ByVal table): Call OpenGLExtCall4(glGetColorTablePtr, vbEmpty, target, format, ptype, table): End Sub
Public Sub glGetColorTableParameterfv(ByVal target As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glGetColorTableParameterfvPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetColorTableParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetColorTableParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetConvolutionFilter(ByVal target As Long, ByVal format As Long, ByVal ptype As Long, ByVal Image): Call OpenGLExtCall4(glGetConvolutionFilterPtr, vbEmpty, target, format, ptype, Image): End Sub
Public Sub glGetConvolutionParameterfv(ByVal target As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glGetConvolutionParameterfvPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetConvolutionParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetConvolutionParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetHistogram(ByVal target As Long, ByVal reset As Integer, ByVal format As Long, ByVal ptype As Long, ByVal values): Call OpenGLExtCall5(glGetHistogramPtr, vbEmpty, target, reset, format, ptype, values): End Sub
Public Sub glGetHistogramParameterfv(ByVal target As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glGetHistogramParameterfvPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetHistogramParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetHistogramParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetMinmax(ByVal target As Long, ByVal reset As Integer, ByVal format As Long, ByVal types As Long, ByVal values): Call OpenGLExtCall5(glGetMinmaxPtr, vbEmpty, target, reset, format, types, values): End Sub
Public Sub glGetMinmaxParameterfv(ByVal target As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glGetMinmaxParameterfvPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetMinmaxParameteriv(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetMinmaxParameterivPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetSeparableFilter(ByVal target As Long, ByVal format As Long, ByVal ptype As Long, ByVal row, ByVal column, ByVal span): Call OpenGLExtCall6(glGetSeparableFilterPtr, vbEmpty, target, format, ptype, row, column, span): End Sub
Public Sub glHistogram(ByVal target As Long, ByVal Width As Long, ByVal internalformat As Long, ByVal sink As Integer): Call OpenGLExtCall4(glHistogramPtr, vbEmpty, target, Width, internalformat, sink): End Sub
Public Sub glMinmax(ByVal target As Long, ByVal internalformat As Long, ByVal sink As Integer): Call OpenGLExtCall3(glMinmaxPtr, vbEmpty, target, internalformat, sink): End Sub
Public Sub glResetHistogram(ByVal target As Long): Call OpenGLExtCall1(glResetHistogramPtr, vbEmpty, target): End Sub
Public Sub glResetMinmax(ByVal target As Long): Call OpenGLExtCall1(glResetMinmaxPtr, vbEmpty, target): End Sub
Public Sub glSeparableFilter2D(ByVal target As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal ptype As Long, ByVal row, ByVal column): Call OpenGLExtCall8(glSeparableFilter2DPtr, vbEmpty, target, internalformat, Width, Height, format, ptype, row, column): End Sub
'------------------------------- GL_ARB_indirect_parameters -------------------------------
Public Sub glMultiDrawArraysIndirectCountARB(ByVal mode As Long, ByVal indirect, ByVal drawCount, ByVal maxDrawCount As Long, ByVal stride As Long): Call OpenGLExtCall5(glMultiDrawArraysIndirectCountARBPtr, vbEmpty, mode, indirect, drawCount, maxDrawCount, stride): End Sub
Public Sub glMultiDrawElementsIndirectCountARB(ByVal mode As Long, ByVal ptype As Long, ByVal indirect, ByVal drawCount, ByVal maxDrawCount As Long, ByVal stride As Long): Call OpenGLExtCall6(glMultiDrawElementsIndirectCountARBPtr, vbEmpty, mode, ptype, indirect, drawCount, maxDrawCount, stride): End Sub
'------------------------------- GL_ARB_instanced_arrays -------------------------------
Public Sub glDrawArraysInstancedARB(ByVal mode As Long, ByVal first As Long, ByVal count As Long, ByVal primcount As Long): Call OpenGLExtCall4(glDrawArraysInstancedARBPtr, vbEmpty, mode, first, count, primcount): End Sub
Public Sub glDrawElementsInstancedARB(ByVal mode As Long, ByVal count As Long, ByVal ptype As Long, ByVal indices, ByVal primcount As Long): Call OpenGLExtCall5(glDrawElementsInstancedARBPtr, vbEmpty, mode, count, ptype, indices, primcount): End Sub
Public Sub glVertexAttribDivisorARB(ByVal index As Long, ByVal divisor As Long): Call OpenGLExtCall2(glVertexAttribDivisorARBPtr, vbEmpty, index, divisor): End Sub
'------------------------------- GL_ARB_internalformat_query -------------------------------
Public Sub glGetInternalformativ(ByVal target As Long, ByVal internalformat As Long, ByVal pname As Long, ByVal bufSize As Long, params As Long): Call OpenGLExtCall5(glGetInternalformativPtr, vbEmpty, target, internalformat, pname, bufSize, VarPtr(params)): End Sub
'------------------------------- GL_ARB_internalformat_query2 -------------------------------
Public Sub glGetInternalformati64v(ByVal target As Long, ByVal internalformat As Long, ByVal pname As Long, ByVal bufSize As Long, params As Currency): Call OpenGLExtCall5(glGetInternalformati64vPtr, vbEmpty, target, internalformat, pname, bufSize, VarPtr(params)): End Sub
'------------------------------- GL_ARB_invalidate_subdata -------------------------------
Public Sub glInvalidateBufferData(ByVal buffer As Long): Call OpenGLExtCall1(glInvalidateBufferDataPtr, vbEmpty, buffer): End Sub
Public Sub glInvalidateBufferSubData(ByVal buffer As Long, ByVal offset, ByVal length): Call OpenGLExtCall3(glInvalidateBufferSubDataPtr, vbEmpty, buffer, offset, length): End Sub
Public Sub glInvalidateFramebuffer(ByVal target As Long, ByVal numAttachments As Long, attachments As Long): Call OpenGLExtCall3(glInvalidateFramebufferPtr, vbEmpty, target, numAttachments, VarPtr(attachments)): End Sub
Public Sub glInvalidateSubFramebuffer(ByVal target As Long, ByVal numAttachments As Long, attachments As Long, ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall7(glInvalidateSubFramebufferPtr, vbEmpty, target, numAttachments, VarPtr(attachments), X, y, Width, Height): End Sub
Public Sub glInvalidateTexImage(ByVal texture As Long, ByVal level As Long): Call OpenGLExtCall2(glInvalidateTexImagePtr, vbEmpty, texture, level): End Sub
Public Sub glInvalidateTexSubImage(ByVal texture As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long): Call OpenGLExtCall8(glInvalidateTexSubImagePtr, vbEmpty, texture, level, xoffset, yoffset, zoffset, Width, Height, depth): End Sub
'------------------------------- GL_ARB_map_buffer_alignment -------------------------------
'------------------------------- GL_ARB_map_buffer_range -------------------------------
Public Sub glFlushMappedBufferRange(ByVal target As Long, ByVal offset, ByVal length): Call OpenGLExtCall3(glFlushMappedBufferRangePtr, vbEmpty, target, offset, length): End Sub
'------------------------------- GL_ARB_matrix_palette -------------------------------
Public Sub glCurrentPaletteMatrixARB(ByVal index As Long): Call OpenGLExtCall1(glCurrentPaletteMatrixARBPtr, vbEmpty, index): End Sub
Public Sub glMatrixIndexPointerARB(ByVal size As Long, ByVal ptype As Long, ByVal stride As Long, ByVal pointer): Call OpenGLExtCall4(glMatrixIndexPointerARBPtr, vbEmpty, size, ptype, stride, pointer): End Sub
Public Sub glMatrixIndexubvARB(ByVal size As Long, indices As Byte): Call OpenGLExtCall2(glMatrixIndexubvARBPtr, vbEmpty, size, VarPtr(indices)): End Sub
Public Sub glMatrixIndexuivARB(ByVal size As Long, indices As Long): Call OpenGLExtCall2(glMatrixIndexuivARBPtr, vbEmpty, size, VarPtr(indices)): End Sub
Public Sub glMatrixIndexusvARB(ByVal size As Long, indices As Long): Call OpenGLExtCall2(glMatrixIndexusvARBPtr, vbEmpty, size, VarPtr(indices)): End Sub
'------------------------------- GL_ARB_multi_bind -------------------------------
Public Sub glBindBuffersBase(ByVal target As Long, ByVal first As Long, ByVal count As Long, buffers As Long): Call OpenGLExtCall4(glBindBuffersBasePtr, vbEmpty, target, first, count, VarPtr(buffers)): End Sub
Public Sub glBindBuffersRange(ByVal target As Long, ByVal first As Long, ByVal count As Long, buffers As Long, offsets, sizes): Call OpenGLExtCall6(glBindBuffersRangePtr, vbEmpty, target, first, count, VarPtr(buffers), VarPtr(offsets), VarPtr(sizes)): End Sub
Public Sub glBindImageTextures(ByVal first As Long, ByVal count As Long, textures As Long): Call OpenGLExtCall3(glBindImageTexturesPtr, vbEmpty, first, count, VarPtr(textures)): End Sub
Public Sub glBindSamplers(ByVal first As Long, ByVal count As Long, samplers As Long): Call OpenGLExtCall3(glBindSamplersPtr, vbEmpty, first, count, VarPtr(samplers)): End Sub
Public Sub glBindTextures(ByVal first As Long, ByVal count As Long, textures As Long): Call OpenGLExtCall3(glBindTexturesPtr, vbEmpty, first, count, VarPtr(textures)): End Sub
Public Sub glBindVertexBuffers(ByVal first As Long, ByVal count As Long, buffers As Long, offsets, strides As Long): Call OpenGLExtCall5(glBindVertexBuffersPtr, vbEmpty, first, count, VarPtr(buffers), VarPtr(offsets), VarPtr(strides)): End Sub
'------------------------------- GL_ARB_multi_draw_indirect -------------------------------
Public Sub glMultiDrawArraysIndirect(ByVal mode As Long, ByVal indirect, ByVal primcount As Long, ByVal stride As Long): Call OpenGLExtCall4(glMultiDrawArraysIndirectPtr, vbEmpty, mode, indirect, primcount, stride): End Sub
Public Sub glMultiDrawElementsIndirect(ByVal mode As Long, ByVal ptype As Long, ByVal indirect, ByVal primcount As Long, ByVal stride As Long): Call OpenGLExtCall5(glMultiDrawElementsIndirectPtr, vbEmpty, mode, ptype, indirect, primcount, stride): End Sub
'------------------------------- GL_ARB_multisample -------------------------------
Public Sub glSampleCoverageARB(ByVal value As Single, ByVal invert As Integer): Call OpenGLExtCall2(glSampleCoverageARBPtr, vbEmpty, value, invert): End Sub
'------------------------------- GL_ARB_multitexture -------------------------------
Public Sub glActiveTextureARB(ByVal texture As Long): Call OpenGLExtCall1(glActiveTextureARBPtr, vbEmpty, texture): End Sub
Public Sub glClientActiveTextureARB(ByVal texture As Long): Call OpenGLExtCall1(glClientActiveTextureARBPtr, vbEmpty, texture): End Sub
Public Sub glMultiTexCoord1dARB(ByVal target As Long, ByVal s As Double): Call OpenGLExtCall2(glMultiTexCoord1dARBPtr, vbEmpty, target, s): End Sub
Public Sub glMultiTexCoord1dvARB(ByVal target As Long, v As Double): Call OpenGLExtCall2(glMultiTexCoord1dvARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord1fARB(ByVal target As Long, ByVal s As Single): Call OpenGLExtCall2(glMultiTexCoord1fARBPtr, vbEmpty, target, s): End Sub
Public Sub glMultiTexCoord1fvARB(ByVal target As Long, v As Single): Call OpenGLExtCall2(glMultiTexCoord1fvARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord1iARB(ByVal target As Long, ByVal s As Long): Call OpenGLExtCall2(glMultiTexCoord1iARBPtr, vbEmpty, target, s): End Sub
Public Sub glMultiTexCoord1ivARB(ByVal target As Long, v As Long): Call OpenGLExtCall2(glMultiTexCoord1ivARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord1sARB(ByVal target As Long, ByVal s As Integer): Call OpenGLExtCall2(glMultiTexCoord1sARBPtr, vbEmpty, target, s): End Sub
Public Sub glMultiTexCoord1svARB(ByVal target As Long, v As Integer): Call OpenGLExtCall2(glMultiTexCoord1svARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord2dARB(ByVal target As Long, ByVal s As Double, ByVal t As Double): Call OpenGLExtCall3(glMultiTexCoord2dARBPtr, vbEmpty, target, s, t): End Sub
Public Sub glMultiTexCoord2dvARB(ByVal target As Long, v As Double): Call OpenGLExtCall2(glMultiTexCoord2dvARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord2fARB(ByVal target As Long, ByVal s As Single, ByVal t As Single): Call OpenGLExtCall3(glMultiTexCoord2fARBPtr, vbEmpty, target, s, t): End Sub
Public Sub glMultiTexCoord2fvARB(ByVal target As Long, v As Single): Call OpenGLExtCall2(glMultiTexCoord2fvARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord2iARB(ByVal target As Long, ByVal s As Long, ByVal t As Long): Call OpenGLExtCall3(glMultiTexCoord2iARBPtr, vbEmpty, target, s, t): End Sub
Public Sub glMultiTexCoord2ivARB(ByVal target As Long, v As Long): Call OpenGLExtCall2(glMultiTexCoord2ivARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord2sARB(ByVal target As Long, ByVal s As Integer, ByVal t As Integer): Call OpenGLExtCall3(glMultiTexCoord2sARBPtr, vbEmpty, target, s, t): End Sub
Public Sub glMultiTexCoord2svARB(ByVal target As Long, v As Integer): Call OpenGLExtCall2(glMultiTexCoord2svARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord3dARB(ByVal target As Long, ByVal s As Double, ByVal t As Double, ByVal r As Double): Call OpenGLExtCall4(glMultiTexCoord3dARBPtr, vbEmpty, target, s, t, r): End Sub
Public Sub glMultiTexCoord3dvARB(ByVal target As Long, v As Double): Call OpenGLExtCall2(glMultiTexCoord3dvARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord3fARB(ByVal target As Long, ByVal s As Single, ByVal t As Single, ByVal r As Single): Call OpenGLExtCall4(glMultiTexCoord3fARBPtr, vbEmpty, target, s, t, r): End Sub
Public Sub glMultiTexCoord3fvARB(ByVal target As Long, v As Single): Call OpenGLExtCall2(glMultiTexCoord3fvARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord3iARB(ByVal target As Long, ByVal s As Long, ByVal t As Long, ByVal r As Long): Call OpenGLExtCall4(glMultiTexCoord3iARBPtr, vbEmpty, target, s, t, r): End Sub
Public Sub glMultiTexCoord3ivARB(ByVal target As Long, v As Long): Call OpenGLExtCall2(glMultiTexCoord3ivARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord3sARB(ByVal target As Long, ByVal s As Integer, ByVal t As Integer, ByVal r As Integer): Call OpenGLExtCall4(glMultiTexCoord3sARBPtr, vbEmpty, target, s, t, r): End Sub
Public Sub glMultiTexCoord3svARB(ByVal target As Long, v As Integer): Call OpenGLExtCall2(glMultiTexCoord3svARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord4dARB(ByVal target As Long, ByVal s As Double, ByVal t As Double, ByVal r As Double, ByVal q As Double): Call OpenGLExtCall5(glMultiTexCoord4dARBPtr, vbEmpty, target, s, t, r, q): End Sub
Public Sub glMultiTexCoord4dvARB(ByVal target As Long, v As Double): Call OpenGLExtCall2(glMultiTexCoord4dvARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord4fARB(ByVal target As Long, ByVal s As Single, ByVal t As Single, ByVal r As Single, ByVal q As Single): Call OpenGLExtCall5(glMultiTexCoord4fARBPtr, vbEmpty, target, s, t, r, q): End Sub
Public Sub glMultiTexCoord4fvARB(ByVal target As Long, v As Single): Call OpenGLExtCall2(glMultiTexCoord4fvARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord4iARB(ByVal target As Long, ByVal s As Long, ByVal t As Long, ByVal r As Long, ByVal q As Long): Call OpenGLExtCall5(glMultiTexCoord4iARBPtr, vbEmpty, target, s, t, r, q): End Sub
Public Sub glMultiTexCoord4ivARB(ByVal target As Long, v As Long): Call OpenGLExtCall2(glMultiTexCoord4ivARBPtr, vbEmpty, target, VarPtr(v)): End Sub
Public Sub glMultiTexCoord4sARB(ByVal target As Long, ByVal s As Integer, ByVal t As Integer, ByVal r As Integer, ByVal q As Integer): Call OpenGLExtCall5(glMultiTexCoord4sARBPtr, vbEmpty, target, s, t, r, q): End Sub
Public Sub glMultiTexCoord4svARB(ByVal target As Long, v As Integer): Call OpenGLExtCall2(glMultiTexCoord4svARBPtr, vbEmpty, target, VarPtr(v)): End Sub
'------------------------------- GL_ARB_occlusion_query -------------------------------
Public Sub glBeginQueryARB(ByVal target As Long, ByVal id As Long): Call OpenGLExtCall2(glBeginQueryARBPtr, vbEmpty, target, id): End Sub
Public Sub glDeleteQueriesARB(ByVal n As Long, ids As Long): Call OpenGLExtCall2(glDeleteQueriesARBPtr, vbEmpty, n, VarPtr(ids)): End Sub
Public Sub glEndQueryARB(ByVal target As Long): Call OpenGLExtCall1(glEndQueryARBPtr, vbEmpty, target): End Sub
Public Sub glGenQueriesARB(ByVal n As Long, ids As Long): Call OpenGLExtCall2(glGenQueriesARBPtr, vbEmpty, n, VarPtr(ids)): End Sub
Public Sub glGetQueryObjectivARB(ByVal id As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetQueryObjectivARBPtr, vbEmpty, id, pname, VarPtr(params)): End Sub
Public Sub glGetQueryObjectuivARB(ByVal id As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetQueryObjectuivARBPtr, vbEmpty, id, pname, VarPtr(params)): End Sub
Public Sub glGetQueryivARB(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetQueryivARBPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Function glIsQueryARB(ByVal id As Long) As Integer: glIsQueryARB = OpenGLExtCall1(glIsQueryARBPtr, vbInteger, id): End Function
'------------------------------- GL_ARB_occlusion_query2 -------------------------------
'------------------------------- GL_ARB_parallel_shader_compile -------------------------------
Public Sub glMaxShaderCompilerThreadsARB(ByVal count As Long): Call OpenGLExtCall1(glMaxShaderCompilerThreadsARBPtr, vbEmpty, count): End Sub
'------------------------------- GL_ARB_pipeline_statistics_query -------------------------------
'------------------------------- GL_ARB_pixel_buffer_object -------------------------------
'------------------------------- GL_ARB_point_parameters -------------------------------
Public Sub glPointParameterfARB(ByVal pname As Long, ByVal param As Single): Call OpenGLExtCall2(glPointParameterfARBPtr, vbEmpty, pname, param): End Sub
Public Sub glPointParameterfvARB(ByVal pname As Long, params As Single): Call OpenGLExtCall2(glPointParameterfvARBPtr, vbEmpty, pname, VarPtr(params)): End Sub
'------------------------------- GL_ARB_point_sprite -------------------------------
'------------------------------- GL_ARB_polygon_offset_clamp -------------------------------
Public Sub glPolygonOffsetClamp(ByVal factor As Single, ByVal units As Single, ByVal clamp As Single): Call OpenGLExtCall3(glPolygonOffsetClampPtr, vbEmpty, factor, units, clamp): End Sub
'------------------------------- GL_ARB_post_depth_coverage -------------------------------
'------------------------------- GL_ARB_program_interface_query -------------------------------
Public Sub glGetProgramInterfaceiv(ByVal program As Long, ByVal programInterface As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall4(glGetProgramInterfaceivPtr, vbEmpty, program, programInterface, pname, VarPtr(params)): End Sub
Public Function glGetProgramResourceIndex(ByVal program As Long, ByVal programInterface As Long, ByVal name) As Long: glGetProgramResourceIndex = OpenGLExtCall3(glGetProgramResourceIndexPtr, vbLong, program, programInterface, name): End Function
Public Function glGetProgramResourceLocation(ByVal program As Long, ByVal programInterface As Long, ByVal name) As Long: glGetProgramResourceLocation = OpenGLExtCall3(glGetProgramResourceLocationPtr, vbLong, program, programInterface, name): End Function
Public Function glGetProgramResourceLocationIndex(ByVal program As Long, ByVal programInterface As Long, ByVal name) As Long: glGetProgramResourceLocationIndex = OpenGLExtCall3(glGetProgramResourceLocationIndexPtr, vbLong, program, programInterface, name): End Function
Public Sub glGetProgramResourceName(ByVal program As Long, ByVal programInterface As Long, ByVal index As Long, ByVal bufSize As Long, length As Long, ByVal name): Call OpenGLExtCall6(glGetProgramResourceNamePtr, vbEmpty, program, programInterface, index, bufSize, VarPtr(length), name): End Sub
Public Sub glGetProgramResourceiv(ByVal program As Long, ByVal programInterface As Long, ByVal index As Long, ByVal propCount As Long, props As Long, ByVal bufSize As Long, length As Long, params As Long): Call OpenGLExtCall8(glGetProgramResourceivPtr, vbEmpty, program, programInterface, index, propCount, VarPtr(props), bufSize, VarPtr(length), VarPtr(params)): End Sub
'------------------------------- GL_ARB_provoking_vertex -------------------------------
Public Sub glProvokingVertex(ByVal mode As Long): Call OpenGLExtCall1(glProvokingVertexPtr, vbEmpty, mode): End Sub
'------------------------------- GL_ARB_query_buffer_object -------------------------------
'------------------------------- GL_ARB_robust_buffer_access_behavior -------------------------------
'------------------------------- GL_ARB_robustness -------------------------------
Public Function glGetGraphicsResetStatusARB() As Long: glGetGraphicsResetStatusARB = OpenGLExtCall0(glGetGraphicsResetStatusARBPtr, vbLong): End Function
Public Sub glGetnColorTableARB(ByVal target As Long, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal table): Call OpenGLExtCall5(glGetnColorTableARBPtr, vbEmpty, target, format, ptype, bufSize, table): End Sub
Public Sub glGetnCompressedTexImageARB(ByVal target As Long, ByVal lod As Long, ByVal bufSize As Long, ByVal img): Call OpenGLExtCall4(glGetnCompressedTexImageARBPtr, vbEmpty, target, lod, bufSize, img): End Sub
Public Sub glGetnConvolutionFilterARB(ByVal target As Long, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal Image): Call OpenGLExtCall5(glGetnConvolutionFilterARBPtr, vbEmpty, target, format, ptype, bufSize, Image): End Sub
Public Sub glGetnHistogramARB(ByVal target As Long, ByVal reset As Integer, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal values): Call OpenGLExtCall6(glGetnHistogramARBPtr, vbEmpty, target, reset, format, ptype, bufSize, values): End Sub
Public Sub glGetnMapdvARB(ByVal target As Long, ByVal query As Long, ByVal bufSize As Long, v As Double): Call OpenGLExtCall4(glGetnMapdvARBPtr, vbEmpty, target, query, bufSize, VarPtr(v)): End Sub
Public Sub glGetnMapfvARB(ByVal target As Long, ByVal query As Long, ByVal bufSize As Long, v As Single): Call OpenGLExtCall4(glGetnMapfvARBPtr, vbEmpty, target, query, bufSize, VarPtr(v)): End Sub
Public Sub glGetnMapivARB(ByVal target As Long, ByVal query As Long, ByVal bufSize As Long, v As Long): Call OpenGLExtCall4(glGetnMapivARBPtr, vbEmpty, target, query, bufSize, VarPtr(v)): End Sub
Public Sub glGetnMinmaxARB(ByVal target As Long, ByVal reset As Integer, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal values): Call OpenGLExtCall6(glGetnMinmaxARBPtr, vbEmpty, target, reset, format, ptype, bufSize, values): End Sub
Public Sub glGetnPixelMapfvARB(ByVal map As Long, ByVal bufSize As Long, values As Single): Call OpenGLExtCall3(glGetnPixelMapfvARBPtr, vbEmpty, map, bufSize, VarPtr(values)): End Sub
Public Sub glGetnPixelMapuivARB(ByVal map As Long, ByVal bufSize As Long, values As Long): Call OpenGLExtCall3(glGetnPixelMapuivARBPtr, vbEmpty, map, bufSize, VarPtr(values)): End Sub
Public Sub glGetnPixelMapusvARB(ByVal map As Long, ByVal bufSize As Long, values As Long): Call OpenGLExtCall3(glGetnPixelMapusvARBPtr, vbEmpty, map, bufSize, VarPtr(values)): End Sub
Public Sub glGetnPolygonStippleARB(ByVal bufSize As Long, pattern As Byte): Call OpenGLExtCall2(glGetnPolygonStippleARBPtr, vbEmpty, bufSize, VarPtr(pattern)): End Sub
Public Sub glGetnSeparableFilterARB(ByVal target As Long, ByVal format As Long, ByVal ptype As Long, ByVal rowBufSize As Long, ByVal row, ByVal columnBufSize As Long, ByVal column, ByVal span): Call OpenGLExtCall8(glGetnSeparableFilterARBPtr, vbEmpty, target, format, ptype, rowBufSize, row, columnBufSize, column, span): End Sub
Public Sub glGetnTexImageARB(ByVal target As Long, ByVal level As Long, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal img): Call OpenGLExtCall6(glGetnTexImageARBPtr, vbEmpty, target, level, format, ptype, bufSize, img): End Sub
Public Sub glGetnUniformdvARB(ByVal program As Long, ByVal location As Long, ByVal bufSize As Long, params As Double): Call OpenGLExtCall4(glGetnUniformdvARBPtr, vbEmpty, program, location, bufSize, VarPtr(params)): End Sub
Public Sub glGetnUniformfvARB(ByVal program As Long, ByVal location As Long, ByVal bufSize As Long, params As Single): Call OpenGLExtCall4(glGetnUniformfvARBPtr, vbEmpty, program, location, bufSize, VarPtr(params)): End Sub
Public Sub glGetnUniformivARB(ByVal program As Long, ByVal location As Long, ByVal bufSize As Long, params As Long): Call OpenGLExtCall4(glGetnUniformivARBPtr, vbEmpty, program, location, bufSize, VarPtr(params)): End Sub
Public Sub glGetnUniformuivARB(ByVal program As Long, ByVal location As Long, ByVal bufSize As Long, params As Long): Call OpenGLExtCall4(glGetnUniformuivARBPtr, vbEmpty, program, location, bufSize, VarPtr(params)): End Sub
Public Sub glReadnPixelsARB(ByVal X As Long, ByVal y As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal ptype As Long, ByVal bufSize As Long, ByVal data): Call OpenGLExtCall8(glReadnPixelsARBPtr, vbEmpty, X, y, Width, Height, format, ptype, bufSize, data): End Sub
'------------------------------- GL_ARB_robustness_application_isolation -------------------------------
'------------------------------- GL_ARB_robustness_share_group_isolation -------------------------------
'------------------------------- GL_ARB_sample_locations -------------------------------
Public Sub glFramebufferSampleLocationsfvARB(ByVal target As Long, ByVal start As Long, ByVal count As Long, v As Single): Call OpenGLExtCall4(glFramebufferSampleLocationsfvARBPtr, vbEmpty, target, start, count, VarPtr(v)): End Sub
Public Sub glNamedFramebufferSampleLocationsfvARB(ByVal framebuffer As Long, ByVal start As Long, ByVal count As Long, v As Single): Call OpenGLExtCall4(glNamedFramebufferSampleLocationsfvARBPtr, vbEmpty, framebuffer, start, count, VarPtr(v)): End Sub
'------------------------------- GL_ARB_sample_shading -------------------------------
Public Sub glMinSampleShadingARB(ByVal value As Single): Call OpenGLExtCall1(glMinSampleShadingARBPtr, vbEmpty, value): End Sub
'------------------------------- GL_ARB_sampler_objects -------------------------------
Public Sub glBindSampler(ByVal unit As Long, ByVal sampler As Long): Call OpenGLExtCall2(glBindSamplerPtr, vbEmpty, unit, sampler): End Sub
Public Sub glDeleteSamplers(ByVal count As Long, samplers As Long): Call OpenGLExtCall2(glDeleteSamplersPtr, vbEmpty, count, VarPtr(samplers)): End Sub
Public Sub glGenSamplers(ByVal count As Long, samplers As Long): Call OpenGLExtCall2(glGenSamplersPtr, vbEmpty, count, VarPtr(samplers)): End Sub
Public Sub glGetSamplerParameterIiv(ByVal sampler As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetSamplerParameterIivPtr, vbEmpty, sampler, pname, VarPtr(params)): End Sub
Public Sub glGetSamplerParameterIuiv(ByVal sampler As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetSamplerParameterIuivPtr, vbEmpty, sampler, pname, VarPtr(params)): End Sub
Public Sub glGetSamplerParameterfv(ByVal sampler As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glGetSamplerParameterfvPtr, vbEmpty, sampler, pname, VarPtr(params)): End Sub
Public Sub glGetSamplerParameteriv(ByVal sampler As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetSamplerParameterivPtr, vbEmpty, sampler, pname, VarPtr(params)): End Sub
Public Function glIsSampler(ByVal sampler As Long) As Integer: glIsSampler = OpenGLExtCall1(glIsSamplerPtr, vbInteger, sampler): End Function
Public Sub glSamplerParameterIiv(ByVal sampler As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glSamplerParameterIivPtr, vbEmpty, sampler, pname, VarPtr(params)): End Sub
Public Sub glSamplerParameterIuiv(ByVal sampler As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glSamplerParameterIuivPtr, vbEmpty, sampler, pname, VarPtr(params)): End Sub
Public Sub glSamplerParameterf(ByVal sampler As Long, ByVal pname As Long, ByVal param As Single): Call OpenGLExtCall3(glSamplerParameterfPtr, vbEmpty, sampler, pname, param): End Sub
Public Sub glSamplerParameterfv(ByVal sampler As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glSamplerParameterfvPtr, vbEmpty, sampler, pname, VarPtr(params)): End Sub
Public Sub glSamplerParameteri(ByVal sampler As Long, ByVal pname As Long, ByVal param As Long): Call OpenGLExtCall3(glSamplerParameteriPtr, vbEmpty, sampler, pname, param): End Sub
Public Sub glSamplerParameteriv(ByVal sampler As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glSamplerParameterivPtr, vbEmpty, sampler, pname, VarPtr(params)): End Sub
'------------------------------- GL_ARB_seamless_cube_map -------------------------------
'------------------------------- GL_ARB_seamless_cubemap_per_texture -------------------------------
'------------------------------- GL_ARB_separate_shader_objects -------------------------------
Public Sub glActiveShaderProgram(ByVal pipeline As Long, ByVal program As Long): Call OpenGLExtCall2(glActiveShaderProgramPtr, vbEmpty, pipeline, program): End Sub
Public Sub glBindProgramPipeline(ByVal pipeline As Long): Call OpenGLExtCall1(glBindProgramPipelinePtr, vbEmpty, pipeline): End Sub
Public Function glCreateShaderProgramv(ByVal ptype As Long, ByVal count As Long, ByVal strings) As Long: glCreateShaderProgramv = OpenGLExtCall3(glCreateShaderProgramvPtr, vbLong, ptype, count, strings): End Function
Public Sub glDeleteProgramPipelines(ByVal n As Long, pipelines As Long): Call OpenGLExtCall2(glDeleteProgramPipelinesPtr, vbEmpty, n, VarPtr(pipelines)): End Sub
Public Sub glGenProgramPipelines(ByVal n As Long, pipelines As Long): Call OpenGLExtCall2(glGenProgramPipelinesPtr, vbEmpty, n, VarPtr(pipelines)): End Sub
Public Sub glGetProgramPipelineInfoLog(ByVal pipeline As Long, ByVal bufSize As Long, length As Long, ByVal infoLog): Call OpenGLExtCall4(glGetProgramPipelineInfoLogPtr, vbEmpty, pipeline, bufSize, VarPtr(length), infoLog): End Sub
Public Sub glGetProgramPipelineiv(ByVal pipeline As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetProgramPipelineivPtr, vbEmpty, pipeline, pname, VarPtr(params)): End Sub
Public Function glIsProgramPipeline(ByVal pipeline As Long) As Integer: glIsProgramPipeline = OpenGLExtCall1(glIsProgramPipelinePtr, vbInteger, pipeline): End Function
Public Sub glProgramUniform1d(ByVal program As Long, ByVal location As Long, ByVal X As Double): Call OpenGLExtCall3(glProgramUniform1dPtr, vbEmpty, program, location, X): End Sub
Public Sub glProgramUniform1dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Double): Call OpenGLExtCall4(glProgramUniform1dvPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform1f(ByVal program As Long, ByVal location As Long, ByVal X As Single): Call OpenGLExtCall3(glProgramUniform1fPtr, vbEmpty, program, location, X): End Sub
Public Sub glProgramUniform1fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Single): Call OpenGLExtCall4(glProgramUniform1fvPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform1i(ByVal program As Long, ByVal location As Long, ByVal X As Long): Call OpenGLExtCall3(glProgramUniform1iPtr, vbEmpty, program, location, X): End Sub
Public Sub glProgramUniform1iv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall4(glProgramUniform1ivPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform1ui(ByVal program As Long, ByVal location As Long, ByVal X As Long): Call OpenGLExtCall3(glProgramUniform1uiPtr, vbEmpty, program, location, X): End Sub
Public Sub glProgramUniform1uiv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall4(glProgramUniform1uivPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform2d(ByVal program As Long, ByVal location As Long, ByVal X As Double, ByVal y As Double): Call OpenGLExtCall4(glProgramUniform2dPtr, vbEmpty, program, location, X, y): End Sub
Public Sub glProgramUniform2dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Double): Call OpenGLExtCall4(glProgramUniform2dvPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform2f(ByVal program As Long, ByVal location As Long, ByVal X As Single, ByVal y As Single): Call OpenGLExtCall4(glProgramUniform2fPtr, vbEmpty, program, location, X, y): End Sub
Public Sub glProgramUniform2fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Single): Call OpenGLExtCall4(glProgramUniform2fvPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform2i(ByVal program As Long, ByVal location As Long, ByVal X As Long, ByVal y As Long): Call OpenGLExtCall4(glProgramUniform2iPtr, vbEmpty, program, location, X, y): End Sub
Public Sub glProgramUniform2iv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall4(glProgramUniform2ivPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform2ui(ByVal program As Long, ByVal location As Long, ByVal X As Long, ByVal y As Long): Call OpenGLExtCall4(glProgramUniform2uiPtr, vbEmpty, program, location, X, y): End Sub
Public Sub glProgramUniform2uiv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall4(glProgramUniform2uivPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform3d(ByVal program As Long, ByVal location As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double): Call OpenGLExtCall5(glProgramUniform3dPtr, vbEmpty, program, location, X, y, z): End Sub
Public Sub glProgramUniform3dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Double): Call OpenGLExtCall4(glProgramUniform3dvPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform3f(ByVal program As Long, ByVal location As Long, ByVal X As Single, ByVal y As Single, ByVal z As Single): Call OpenGLExtCall5(glProgramUniform3fPtr, vbEmpty, program, location, X, y, z): End Sub
Public Sub glProgramUniform3fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Single): Call OpenGLExtCall4(glProgramUniform3fvPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform3i(ByVal program As Long, ByVal location As Long, ByVal X As Long, ByVal y As Long, ByVal z As Long): Call OpenGLExtCall5(glProgramUniform3iPtr, vbEmpty, program, location, X, y, z): End Sub
Public Sub glProgramUniform3iv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall4(glProgramUniform3ivPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform3ui(ByVal program As Long, ByVal location As Long, ByVal X As Long, ByVal y As Long, ByVal z As Long): Call OpenGLExtCall5(glProgramUniform3uiPtr, vbEmpty, program, location, X, y, z): End Sub
Public Sub glProgramUniform3uiv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall4(glProgramUniform3uivPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform4d(ByVal program As Long, ByVal location As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double, ByVal w As Double): Call OpenGLExtCall6(glProgramUniform4dPtr, vbEmpty, program, location, X, y, z, w): End Sub
Public Sub glProgramUniform4dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Double): Call OpenGLExtCall4(glProgramUniform4dvPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform4f(ByVal program As Long, ByVal location As Long, ByVal X As Single, ByVal y As Single, ByVal z As Single, ByVal w As Single): Call OpenGLExtCall6(glProgramUniform4fPtr, vbEmpty, program, location, X, y, z, w): End Sub
Public Sub glProgramUniform4fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Single): Call OpenGLExtCall4(glProgramUniform4fvPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform4i(ByVal program As Long, ByVal location As Long, ByVal X As Long, ByVal y As Long, ByVal z As Long, ByVal w As Long): Call OpenGLExtCall6(glProgramUniform4iPtr, vbEmpty, program, location, X, y, z, w): End Sub
Public Sub glProgramUniform4iv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall4(glProgramUniform4ivPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniform4ui(ByVal program As Long, ByVal location As Long, ByVal X As Long, ByVal y As Long, ByVal z As Long, ByVal w As Long): Call OpenGLExtCall6(glProgramUniform4uiPtr, vbEmpty, program, location, X, y, z, w): End Sub
Public Sub glProgramUniform4uiv(ByVal program As Long, ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall4(glProgramUniform4uivPtr, vbEmpty, program, location, count, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix2dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix2dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix2fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix2fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix2x3dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix2x3dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix2x3fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix2x3fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix2x4dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix2x4dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix2x4fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix2x4fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix3dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix3dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix3fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix3fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix3x2dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix3x2dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix3x2fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix3x2fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix3x4dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix3x4dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix3x4fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix3x4fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix4dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix4dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix4fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix4fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix4x2dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix4x2dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix4x2fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix4x2fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix4x3dv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Double): Call OpenGLExtCall5(glProgramUniformMatrix4x3dvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glProgramUniformMatrix4x3fv(ByVal program As Long, ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall5(glProgramUniformMatrix4x3fvPtr, vbEmpty, program, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUseProgramStages(ByVal pipeline As Long, ByVal stages As Long, ByVal program As Long): Call OpenGLExtCall3(glUseProgramStagesPtr, vbEmpty, pipeline, stages, program): End Sub
Public Sub glValidateProgramPipeline(ByVal pipeline As Long): Call OpenGLExtCall1(glValidateProgramPipelinePtr, vbEmpty, pipeline): End Sub
'------------------------------- GL_ARB_shader_atomic_counter_ops -------------------------------
'------------------------------- GL_ARB_shader_atomic_counters -------------------------------
Public Sub glGetActiveAtomicCounterBufferiv(ByVal program As Long, ByVal bufferIndex As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall4(glGetActiveAtomicCounterBufferivPtr, vbEmpty, program, bufferIndex, pname, VarPtr(params)): End Sub
'------------------------------- GL_ARB_shader_ballot -------------------------------
'------------------------------- GL_ARB_shader_bit_encoding -------------------------------
'------------------------------- GL_ARB_shader_clock -------------------------------
'------------------------------- GL_ARB_shader_draw_parameters -------------------------------
'------------------------------- GL_ARB_shader_group_vote -------------------------------
'------------------------------- GL_ARB_shader_image_load_store -------------------------------
Public Sub glBindImageTexture(ByVal unit As Long, ByVal texture As Long, ByVal level As Long, ByVal layered As Integer, ByVal layer As Long, ByVal access As Long, ByVal format As Long): Call OpenGLExtCall7(glBindImageTexturePtr, vbEmpty, unit, texture, level, layered, layer, access, format): End Sub
Public Sub glMemoryBarrier(ByVal barriers As Long): Call OpenGLExtCall1(glMemoryBarrierPtr, vbEmpty, barriers): End Sub
'------------------------------- GL_ARB_shader_image_size -------------------------------
'------------------------------- GL_ARB_shader_objects -------------------------------
Public Sub glAttachObjectARB(ByVal containerObj, ByVal obj): Call OpenGLExtCall2(glAttachObjectARBPtr, vbEmpty, containerObj, obj): End Sub
Public Sub glCompileShaderARB(ByVal shaderObj): Call OpenGLExtCall1(glCompileShaderARBPtr, vbEmpty, shaderObj): End Sub
Public Function glCreateProgramObjectARB(): glCreateProgramObjectARB = OpenGLExtCall0(glCreateProgramObjectARBPtr, vbLongPtr): End Function
Public Function glCreateShaderObjectARB(ByVal shadertype As Long): glCreateShaderObjectARB = OpenGLExtCall1(glCreateShaderObjectARBPtr, vbLongPtr, shadertype): End Function
Public Sub glDeleteObjectARB(ByVal obj): Call OpenGLExtCall1(glDeleteObjectARBPtr, vbEmpty, obj): End Sub
Public Sub glDetachObjectARB(ByVal containerObj, ByVal attachedObj): Call OpenGLExtCall2(glDetachObjectARBPtr, vbEmpty, containerObj, attachedObj): End Sub
Public Sub glGetActiveUniformARB(ByVal programObj, ByVal index As Long, ByVal maxLength As Long, length As Long, size As Long, ptype As Long, ByVal name): Call OpenGLExtCall7(glGetActiveUniformARBPtr, vbEmpty, programObj, index, maxLength, VarPtr(length), VarPtr(size), VarPtr(ptype), name): End Sub
Public Sub glGetAttachedObjectsARB(ByVal containerObj, ByVal maxCount As Long, count As Long, obj): Call OpenGLExtCall4(glGetAttachedObjectsARBPtr, vbEmpty, containerObj, maxCount, VarPtr(count), VarPtr(obj)): End Sub
Public Function glGetHandleARB(ByVal pname As Long): glGetHandleARB = OpenGLExtCall1(glGetHandleARBPtr, vbLongPtr, pname): End Function
Public Sub glGetInfoLogARB(ByVal obj, ByVal maxLength As Long, length As Long, ByVal infoLog): Call OpenGLExtCall4(glGetInfoLogARBPtr, vbEmpty, obj, maxLength, VarPtr(length), infoLog): End Sub
Public Sub glGetObjectParameterfvARB(ByVal obj, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glGetObjectParameterfvARBPtr, vbEmpty, obj, pname, VarPtr(params)): End Sub
Public Sub glGetObjectParameterivARB(ByVal obj, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetObjectParameterivARBPtr, vbEmpty, obj, pname, VarPtr(params)): End Sub
Public Sub glGetShaderSourceARB(ByVal obj, ByVal maxLength As Long, length As Long, ByVal source): Call OpenGLExtCall4(glGetShaderSourceARBPtr, vbEmpty, obj, maxLength, VarPtr(length), source): End Sub
Public Function glGetUniformLocationARB(ByVal programObj, ByVal name) As Long: glGetUniformLocationARB = OpenGLExtCall2(glGetUniformLocationARBPtr, vbLong, programObj, name): End Function
Public Sub glGetUniformfvARB(ByVal programObj, ByVal location As Long, params As Single): Call OpenGLExtCall3(glGetUniformfvARBPtr, vbEmpty, programObj, location, VarPtr(params)): End Sub
Public Sub glGetUniformivARB(ByVal programObj, ByVal location As Long, params As Long): Call OpenGLExtCall3(glGetUniformivARBPtr, vbEmpty, programObj, location, VarPtr(params)): End Sub
Public Sub glLinkProgramARB(ByVal programObj): Call OpenGLExtCall1(glLinkProgramARBPtr, vbEmpty, programObj): End Sub
Public Sub glShaderSourceARB(ByVal shaderObj, ByVal count As Long, ByVal pstring, length As Long): Call OpenGLExtCall4(glShaderSourceARBPtr, vbEmpty, shaderObj, count, pstring, VarPtr(length)): End Sub
Public Sub glUniform1fARB(ByVal location As Long, ByVal v0 As Single): Call OpenGLExtCall2(glUniform1fARBPtr, vbEmpty, location, v0): End Sub
Public Sub glUniform1fvARB(ByVal location As Long, ByVal count As Long, value As Single): Call OpenGLExtCall3(glUniform1fvARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform1iARB(ByVal location As Long, ByVal v0 As Long): Call OpenGLExtCall2(glUniform1iARBPtr, vbEmpty, location, v0): End Sub
Public Sub glUniform1ivARB(ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall3(glUniform1ivARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform2fARB(ByVal location As Long, ByVal v0 As Single, ByVal v1 As Single): Call OpenGLExtCall3(glUniform2fARBPtr, vbEmpty, location, v0, v1): End Sub
Public Sub glUniform2fvARB(ByVal location As Long, ByVal count As Long, value As Single): Call OpenGLExtCall3(glUniform2fvARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform2iARB(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long): Call OpenGLExtCall3(glUniform2iARBPtr, vbEmpty, location, v0, v1): End Sub
Public Sub glUniform2ivARB(ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall3(glUniform2ivARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform3fARB(ByVal location As Long, ByVal v0 As Single, ByVal v1 As Single, ByVal v2 As Single): Call OpenGLExtCall4(glUniform3fARBPtr, vbEmpty, location, v0, v1, v2): End Sub
Public Sub glUniform3fvARB(ByVal location As Long, ByVal count As Long, value As Single): Call OpenGLExtCall3(glUniform3fvARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform3iARB(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long): Call OpenGLExtCall4(glUniform3iARBPtr, vbEmpty, location, v0, v1, v2): End Sub
Public Sub glUniform3ivARB(ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall3(glUniform3ivARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform4fARB(ByVal location As Long, ByVal v0 As Single, ByVal v1 As Single, ByVal v2 As Single, ByVal v3 As Single): Call OpenGLExtCall5(glUniform4fARBPtr, vbEmpty, location, v0, v1, v2, v3): End Sub
Public Sub glUniform4fvARB(ByVal location As Long, ByVal count As Long, value As Single): Call OpenGLExtCall3(glUniform4fvARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniform4iARB(ByVal location As Long, ByVal v0 As Long, ByVal v1 As Long, ByVal v2 As Long, ByVal v3 As Long): Call OpenGLExtCall5(glUniform4iARBPtr, vbEmpty, location, v0, v1, v2, v3): End Sub
Public Sub glUniform4ivARB(ByVal location As Long, ByVal count As Long, value As Long): Call OpenGLExtCall3(glUniform4ivARBPtr, vbEmpty, location, count, VarPtr(value)): End Sub
Public Sub glUniformMatrix2fvARB(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix2fvARBPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix3fvARB(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix3fvARBPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUniformMatrix4fvARB(ByVal location As Long, ByVal count As Long, ByVal transpose As Integer, value As Single): Call OpenGLExtCall4(glUniformMatrix4fvARBPtr, vbEmpty, location, count, transpose, VarPtr(value)): End Sub
Public Sub glUseProgramObjectARB(ByVal programObj): Call OpenGLExtCall1(glUseProgramObjectARBPtr, vbEmpty, programObj): End Sub
Public Sub glValidateProgramARB(ByVal programObj): Call OpenGLExtCall1(glValidateProgramARBPtr, vbEmpty, programObj): End Sub
'------------------------------- GL_ARB_shader_precision -------------------------------
'------------------------------- GL_ARB_shader_stencil_export -------------------------------
'------------------------------- GL_ARB_shader_storage_buffer_object -------------------------------
Public Sub glShaderStorageBlockBinding(ByVal program As Long, ByVal storageBlockIndex As Long, ByVal storageBlockBinding As Long): Call OpenGLExtCall3(glShaderStorageBlockBindingPtr, vbEmpty, program, storageBlockIndex, storageBlockBinding): End Sub
'------------------------------- GL_ARB_shader_subroutine -------------------------------
Public Sub glGetActiveSubroutineName(ByVal program As Long, ByVal shadertype As Long, ByVal index As Long, ByVal bufSize As Long, length As Long, ByVal name): Call OpenGLExtCall6(glGetActiveSubroutineNamePtr, vbEmpty, program, shadertype, index, bufSize, VarPtr(length), name): End Sub
Public Sub glGetActiveSubroutineUniformName(ByVal program As Long, ByVal shadertype As Long, ByVal index As Long, ByVal bufSize As Long, length As Long, ByVal name): Call OpenGLExtCall6(glGetActiveSubroutineUniformNamePtr, vbEmpty, program, shadertype, index, bufSize, VarPtr(length), name): End Sub
Public Sub glGetActiveSubroutineUniformiv(ByVal program As Long, ByVal shadertype As Long, ByVal index As Long, ByVal pname As Long, values As Long): Call OpenGLExtCall5(glGetActiveSubroutineUniformivPtr, vbEmpty, program, shadertype, index, pname, VarPtr(values)): End Sub
Public Sub glGetProgramStageiv(ByVal program As Long, ByVal shadertype As Long, ByVal pname As Long, values As Long): Call OpenGLExtCall4(glGetProgramStageivPtr, vbEmpty, program, shadertype, pname, VarPtr(values)): End Sub
Public Function glGetSubroutineIndex(ByVal program As Long, ByVal shadertype As Long, ByVal name) As Long: glGetSubroutineIndex = OpenGLExtCall3(glGetSubroutineIndexPtr, vbLong, program, shadertype, name): End Function
Public Function glGetSubroutineUniformLocation(ByVal program As Long, ByVal shadertype As Long, ByVal name) As Long: glGetSubroutineUniformLocation = OpenGLExtCall3(glGetSubroutineUniformLocationPtr, vbLong, program, shadertype, name): End Function
Public Sub glGetUniformSubroutineuiv(ByVal shadertype As Long, ByVal location As Long, params As Long): Call OpenGLExtCall3(glGetUniformSubroutineuivPtr, vbEmpty, shadertype, location, VarPtr(params)): End Sub
Public Sub glUniformSubroutinesuiv(ByVal shadertype As Long, ByVal count As Long, indices As Long): Call OpenGLExtCall3(glUniformSubroutinesuivPtr, vbEmpty, shadertype, count, VarPtr(indices)): End Sub
'------------------------------- GL_ARB_shader_texture_image_samples -------------------------------
'------------------------------- GL_ARB_shader_texture_lod -------------------------------
'------------------------------- GL_ARB_shader_viewport_layer_array -------------------------------
'------------------------------- GL_ARB_shading_language_100 -------------------------------
'------------------------------- GL_ARB_shading_language_420pack -------------------------------
'------------------------------- GL_ARB_shading_language_include -------------------------------
Public Sub glCompileShaderIncludeARB(ByVal shader As Long, ByVal count As Long, ByVal path, length As Long): Call OpenGLExtCall4(glCompileShaderIncludeARBPtr, vbEmpty, shader, count, path, VarPtr(length)): End Sub
Public Sub glDeleteNamedStringARB(ByVal namelen As Long, ByVal name): Call OpenGLExtCall2(glDeleteNamedStringARBPtr, vbEmpty, namelen, name): End Sub
Public Sub glGetNamedStringARB(ByVal namelen As Long, ByVal name, ByVal bufSize As Long, stringlen As Long, ByVal pstring): Call OpenGLExtCall5(glGetNamedStringARBPtr, vbEmpty, namelen, name, bufSize, VarPtr(stringlen), pstring): End Sub
Public Sub glGetNamedStringivARB(ByVal namelen As Long, ByVal name, ByVal pname As Long, params As Long): Call OpenGLExtCall4(glGetNamedStringivARBPtr, vbEmpty, namelen, name, pname, VarPtr(params)): End Sub
Public Function glIsNamedStringARB(ByVal namelen As Long, ByVal name) As Integer: glIsNamedStringARB = OpenGLExtCall2(glIsNamedStringARBPtr, vbInteger, namelen, name): End Function
Public Sub glNamedStringARB(ByVal ptype As Long, ByVal namelen As Long, ByVal name, ByVal stringlen As Long, ByVal pstring): Call OpenGLExtCall5(glNamedStringARBPtr, vbEmpty, ptype, namelen, name, stringlen, pstring): End Sub
'------------------------------- GL_ARB_shading_language_packing -------------------------------
'------------------------------- GL_ARB_shadow -------------------------------
'------------------------------- GL_ARB_shadow_ambient -------------------------------
'------------------------------- GL_ARB_sparse_buffer -------------------------------
Public Sub glBufferPageCommitmentARB(ByVal target As Long, ByVal offset, ByVal size, ByVal commit As Integer): Call OpenGLExtCall4(glBufferPageCommitmentARBPtr, vbEmpty, target, offset, size, commit): End Sub
'------------------------------- GL_ARB_sparse_texture -------------------------------
Public Sub glTexPageCommitmentARB(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal commit As Integer): Call OpenGLExtCall9(glTexPageCommitmentARBPtr, vbEmpty, target, level, xoffset, yoffset, zoffset, Width, Height, depth, commit): End Sub
'------------------------------- GL_ARB_sparse_texture2 -------------------------------
'------------------------------- GL_ARB_sparse_texture_clamp -------------------------------
'------------------------------- GL_ARB_spirv_extensions -------------------------------
'------------------------------- GL_ARB_stencil_texturing -------------------------------
'------------------------------- GL_ARB_sync -------------------------------
Public Function glClientWaitSync(ByVal GLsync As Long, ByVal flags As Long, ByVal timeout As Currency) As Long: glClientWaitSync = OpenGLExtCall3(glClientWaitSyncPtr, vbLong, GLsync, flags, timeout): End Function
Public Sub glDeleteSync(ByVal GLsync As Long): Call OpenGLExtCall1(glDeleteSyncPtr, vbEmpty, GLsync): End Sub
Public Function glFenceSync(ByVal condition As Long, ByVal flags As Long) As Long: glFenceSync = OpenGLExtCall2(glFenceSyncPtr, vbLong, condition, flags): End Function
Public Sub glGetInteger64v(ByVal pname As Long, params As Currency): Call OpenGLExtCall2(glGetInteger64vPtr, vbEmpty, pname, VarPtr(params)): End Sub
Public Sub glGetSynciv(ByVal GLsync As Long, ByVal pname As Long, ByVal bufSize As Long, length As Long, values As Long): Call OpenGLExtCall5(glGetSyncivPtr, vbEmpty, GLsync, pname, bufSize, VarPtr(length), VarPtr(values)): End Sub
Public Function glIsSync(ByVal GLsync As Long) As Integer: glIsSync = OpenGLExtCall1(glIsSyncPtr, vbInteger, GLsync): End Function
Public Sub glWaitSync(ByVal GLsync As Long, ByVal flags As Long, ByVal timeout As Currency): Call OpenGLExtCall3(glWaitSyncPtr, vbEmpty, GLsync, flags, timeout): End Sub
'------------------------------- GL_ARB_tessellation_shader -------------------------------
Public Sub glPatchParameterfv(ByVal pname As Long, values As Single): Call OpenGLExtCall2(glPatchParameterfvPtr, vbEmpty, pname, VarPtr(values)): End Sub
Public Sub glPatchParameteri(ByVal pname As Long, ByVal value As Long): Call OpenGLExtCall2(glPatchParameteriPtr, vbEmpty, pname, value): End Sub
'------------------------------- GL_ARB_texture_barrier -------------------------------
Public Sub glTextureBarrier(): Call OpenGLExtCall0(glTextureBarrierPtr, vbEmpty): End Sub
'------------------------------- GL_ARB_texture_border_clamp -------------------------------
'------------------------------- GL_ARB_texture_buffer_object -------------------------------
Public Sub glTexBufferARB(ByVal target As Long, ByVal internalformat As Long, ByVal buffer As Long): Call OpenGLExtCall3(glTexBufferARBPtr, vbEmpty, target, internalformat, buffer): End Sub
'------------------------------- GL_ARB_texture_buffer_object_rgb32 -------------------------------
'------------------------------- GL_ARB_texture_buffer_range -------------------------------
Public Sub glTexBufferRange(ByVal target As Long, ByVal internalformat As Long, ByVal buffer As Long, ByVal offset, ByVal size): Call OpenGLExtCall5(glTexBufferRangePtr, vbEmpty, target, internalformat, buffer, offset, size): End Sub
Public Sub glTextureBufferRangeEXT(ByVal texture As Long, ByVal target As Long, ByVal internalformat As Long, ByVal buffer As Long, ByVal offset, ByVal size): Call OpenGLExtCall6(glTextureBufferRangeEXTPtr, vbEmpty, texture, target, internalformat, buffer, offset, size): End Sub
'------------------------------- GL_ARB_texture_compression -------------------------------
Public Sub glCompressedTexImage1DARB(ByVal target As Long, ByVal level As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal border As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall7(glCompressedTexImage1DARBPtr, vbEmpty, target, level, internalformat, Width, border, imageSize, data): End Sub
Public Sub glCompressedTexImage2DARB(ByVal target As Long, ByVal level As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal border As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall8(glCompressedTexImage2DARBPtr, vbEmpty, target, level, internalformat, Width, Height, border, imageSize, data): End Sub
Public Sub glCompressedTexImage3DARB(ByVal target As Long, ByVal level As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal border As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall9(glCompressedTexImage3DARBPtr, vbEmpty, target, level, internalformat, Width, Height, depth, border, imageSize, data): End Sub
Public Sub glCompressedTexSubImage1DARB(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal Width As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall7(glCompressedTexSubImage1DARBPtr, vbEmpty, target, level, xoffset, Width, format, imageSize, data): End Sub
Public Sub glCompressedTexSubImage2DARB(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall9(glCompressedTexSubImage2DARBPtr, vbEmpty, target, level, xoffset, yoffset, Width, Height, format, imageSize, data): End Sub
Public Sub glCompressedTexSubImage3DARB(ByVal target As Long, ByVal level As Long, ByVal xoffset As Long, ByVal yoffset As Long, ByVal zoffset As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal format As Long, ByVal imageSize As Long, ByVal data): Call OpenGLExtCall11(glCompressedTexSubImage3DARBPtr, vbEmpty, target, level, xoffset, yoffset, zoffset, Width, Height, depth, format, imageSize, data): End Sub
Public Sub glGetCompressedTexImageARB(ByVal target As Long, ByVal lod As Long, ByVal img): Call OpenGLExtCall3(glGetCompressedTexImageARBPtr, vbEmpty, target, lod, img): End Sub
'------------------------------- GL_ARB_texture_compression_bptc -------------------------------
'------------------------------- GL_ARB_texture_compression_rgtc -------------------------------
'------------------------------- GL_ARB_texture_cube_map -------------------------------
'------------------------------- GL_ARB_texture_cube_map_array -------------------------------
'------------------------------- GL_ARB_texture_env_add -------------------------------
'------------------------------- GL_ARB_texture_env_combine -------------------------------
'------------------------------- GL_ARB_texture_env_crossbar -------------------------------
'------------------------------- GL_ARB_texture_env_dot3 -------------------------------
'------------------------------- GL_ARB_texture_filter_anisotropic -------------------------------
'------------------------------- GL_ARB_texture_filter_minmax -------------------------------
'------------------------------- GL_ARB_texture_float -------------------------------
'------------------------------- GL_ARB_texture_gather -------------------------------
'------------------------------- GL_ARB_texture_mirror_clamp_to_edge -------------------------------
'------------------------------- GL_ARB_texture_mirrored_repeat -------------------------------
'------------------------------- GL_ARB_texture_multisample -------------------------------
Public Sub glGetMultisamplefv(ByVal pname As Long, ByVal index As Long, val As Single): Call OpenGLExtCall3(glGetMultisamplefvPtr, vbEmpty, pname, index, VarPtr(val)): End Sub
Public Sub glSampleMaski(ByVal index As Long, ByVal mask As Long): Call OpenGLExtCall2(glSampleMaskiPtr, vbEmpty, index, mask): End Sub
Public Sub glTexImage2DMultisample(ByVal target As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal fixedSampleLocations As Integer): Call OpenGLExtCall6(glTexImage2DMultisamplePtr, vbEmpty, target, samples, internalformat, Width, Height, fixedSampleLocations): End Sub
Public Sub glTexImage3DMultisample(ByVal target As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal fixedSampleLocations As Integer): Call OpenGLExtCall7(glTexImage3DMultisamplePtr, vbEmpty, target, samples, internalformat, Width, Height, depth, fixedSampleLocations): End Sub
'------------------------------- GL_ARB_texture_non_power_of_two -------------------------------
'------------------------------- GL_ARB_texture_query_levels -------------------------------
'------------------------------- GL_ARB_texture_query_lod -------------------------------
'------------------------------- GL_ARB_texture_rectangle -------------------------------
'------------------------------- GL_ARB_texture_rg -------------------------------
'------------------------------- GL_ARB_texture_rgb10_a2ui -------------------------------
'------------------------------- GL_ARB_texture_stencil8 -------------------------------
'------------------------------- GL_ARB_texture_storage -------------------------------
Public Sub glTexStorage1D(ByVal target As Long, ByVal levels As Long, ByVal internalformat As Long, ByVal Width As Long): Call OpenGLExtCall4(glTexStorage1DPtr, vbEmpty, target, levels, internalformat, Width): End Sub
Public Sub glTexStorage2D(ByVal target As Long, ByVal levels As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall5(glTexStorage2DPtr, vbEmpty, target, levels, internalformat, Width, Height): End Sub
Public Sub glTexStorage3D(ByVal target As Long, ByVal levels As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long): Call OpenGLExtCall6(glTexStorage3DPtr, vbEmpty, target, levels, internalformat, Width, Height, depth): End Sub
'------------------------------- GL_ARB_texture_storage_multisample -------------------------------
Public Sub glTexStorage2DMultisample(ByVal target As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal fixedSampleLocations As Integer): Call OpenGLExtCall6(glTexStorage2DMultisamplePtr, vbEmpty, target, samples, internalformat, Width, Height, fixedSampleLocations): End Sub
Public Sub glTexStorage3DMultisample(ByVal target As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal fixedSampleLocations As Integer): Call OpenGLExtCall7(glTexStorage3DMultisamplePtr, vbEmpty, target, samples, internalformat, Width, Height, depth, fixedSampleLocations): End Sub
Public Sub glTextureStorage2DMultisampleEXT(ByVal texture As Long, ByVal target As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal fixedSampleLocations As Integer): Call OpenGLExtCall7(glTextureStorage2DMultisampleEXTPtr, vbEmpty, texture, target, samples, internalformat, Width, Height, fixedSampleLocations): End Sub
Public Sub glTextureStorage3DMultisampleEXT(ByVal texture As Long, ByVal target As Long, ByVal samples As Long, ByVal internalformat As Long, ByVal Width As Long, ByVal Height As Long, ByVal depth As Long, ByVal fixedSampleLocations As Integer): Call OpenGLExtCall8(glTextureStorage3DMultisampleEXTPtr, vbEmpty, texture, target, samples, internalformat, Width, Height, depth, fixedSampleLocations): End Sub
'------------------------------- GL_ARB_texture_swizzle -------------------------------
'------------------------------- GL_ARB_texture_view -------------------------------
Public Sub glTextureView(ByVal texture As Long, ByVal target As Long, ByVal origtexture As Long, ByVal internalformat As Long, ByVal minlevel As Long, ByVal numlevels As Long, ByVal minlayer As Long, ByVal numLayers As Long): Call OpenGLExtCall8(glTextureViewPtr, vbEmpty, texture, target, origtexture, internalformat, minlevel, numlevels, minlayer, numLayers): End Sub
'------------------------------- GL_ARB_timer_query -------------------------------
Public Sub glGetQueryObjecti64v(ByVal id As Long, ByVal pname As Long, params As Currency): Call OpenGLExtCall3(glGetQueryObjecti64vPtr, vbEmpty, id, pname, VarPtr(params)): End Sub
Public Sub glGetQueryObjectui64v(ByVal id As Long, ByVal pname As Long, params As Currency): Call OpenGLExtCall3(glGetQueryObjectui64vPtr, vbEmpty, id, pname, VarPtr(params)): End Sub
Public Sub glQueryCounter(ByVal id As Long, ByVal target As Long): Call OpenGLExtCall2(glQueryCounterPtr, vbEmpty, id, target): End Sub
'------------------------------- GL_ARB_transform_feedback2 -------------------------------
Public Sub glBindTransformFeedback(ByVal target As Long, ByVal id As Long): Call OpenGLExtCall2(glBindTransformFeedbackPtr, vbEmpty, target, id): End Sub
Public Sub glDeleteTransformFeedbacks(ByVal n As Long, ids As Long): Call OpenGLExtCall2(glDeleteTransformFeedbacksPtr, vbEmpty, n, VarPtr(ids)): End Sub
Public Sub glDrawTransformFeedback(ByVal mode As Long, ByVal id As Long): Call OpenGLExtCall2(glDrawTransformFeedbackPtr, vbEmpty, mode, id): End Sub
Public Sub glGenTransformFeedbacks(ByVal n As Long, ids As Long): Call OpenGLExtCall2(glGenTransformFeedbacksPtr, vbEmpty, n, VarPtr(ids)): End Sub
Public Function glIsTransformFeedback(ByVal id As Long) As Integer: glIsTransformFeedback = OpenGLExtCall1(glIsTransformFeedbackPtr, vbInteger, id): End Function
Public Sub glPauseTransformFeedback(): Call OpenGLExtCall0(glPauseTransformFeedbackPtr, vbEmpty): End Sub
Public Sub glResumeTransformFeedback(): Call OpenGLExtCall0(glResumeTransformFeedbackPtr, vbEmpty): End Sub
'------------------------------- GL_ARB_transform_feedback3 -------------------------------
Public Sub glBeginQueryIndexed(ByVal target As Long, ByVal index As Long, ByVal id As Long): Call OpenGLExtCall3(glBeginQueryIndexedPtr, vbEmpty, target, index, id): End Sub
Public Sub glDrawTransformFeedbackStream(ByVal mode As Long, ByVal id As Long, ByVal stream As Long): Call OpenGLExtCall3(glDrawTransformFeedbackStreamPtr, vbEmpty, mode, id, stream): End Sub
Public Sub glEndQueryIndexed(ByVal target As Long, ByVal index As Long): Call OpenGLExtCall2(glEndQueryIndexedPtr, vbEmpty, target, index): End Sub
Public Sub glGetQueryIndexediv(ByVal target As Long, ByVal index As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall4(glGetQueryIndexedivPtr, vbEmpty, target, index, pname, VarPtr(params)): End Sub
'------------------------------- GL_ARB_transform_feedback_instanced -------------------------------
Public Sub glDrawTransformFeedbackInstanced(ByVal mode As Long, ByVal id As Long, ByVal primcount As Long): Call OpenGLExtCall3(glDrawTransformFeedbackInstancedPtr, vbEmpty, mode, id, primcount): End Sub
Public Sub glDrawTransformFeedbackStreamInstanced(ByVal mode As Long, ByVal id As Long, ByVal stream As Long, ByVal primcount As Long): Call OpenGLExtCall4(glDrawTransformFeedbackStreamInstancedPtr, vbEmpty, mode, id, stream, primcount): End Sub
'------------------------------- GL_ARB_transform_feedback_overflow_query -------------------------------
'------------------------------- GL_ARB_transpose_matrix -------------------------------
Public Sub glLoadTransposeMatrixdARB(m As Double): Call OpenGLExtCall1(glLoadTransposeMatrixdARBPtr, vbEmpty, VarPtr(m)): End Sub
Public Sub glLoadTransposeMatrixfARB(m As Single): Call OpenGLExtCall1(glLoadTransposeMatrixfARBPtr, vbEmpty, VarPtr(m)): End Sub
Public Sub glMultTransposeMatrixdARB(m As Double): Call OpenGLExtCall1(glMultTransposeMatrixdARBPtr, vbEmpty, VarPtr(m)): End Sub
Public Sub glMultTransposeMatrixfARB(m As Single): Call OpenGLExtCall1(glMultTransposeMatrixfARBPtr, vbEmpty, VarPtr(m)): End Sub
'------------------------------- GL_ARB_uniform_buffer_object -------------------------------
Public Sub glBindBufferBase(ByVal target As Long, ByVal index As Long, ByVal buffer As Long): Call OpenGLExtCall3(glBindBufferBasePtr, vbEmpty, target, index, buffer): End Sub
Public Sub glBindBufferRange(ByVal target As Long, ByVal index As Long, ByVal buffer As Long, ByVal offset, ByVal size): Call OpenGLExtCall5(glBindBufferRangePtr, vbEmpty, target, index, buffer, offset, size): End Sub
Public Sub glGetActiveUniformBlockName(ByVal program As Long, ByVal uniformBlockIndex As Long, ByVal bufSize As Long, length As Long, ByVal uniformBlockName): Call OpenGLExtCall5(glGetActiveUniformBlockNamePtr, vbEmpty, program, uniformBlockIndex, bufSize, VarPtr(length), uniformBlockName): End Sub
Public Sub glGetActiveUniformBlockiv(ByVal program As Long, ByVal uniformBlockIndex As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall4(glGetActiveUniformBlockivPtr, vbEmpty, program, uniformBlockIndex, pname, VarPtr(params)): End Sub
Public Sub glGetActiveUniformName(ByVal program As Long, ByVal uniformIndex As Long, ByVal bufSize As Long, length As Long, ByVal uniformName): Call OpenGLExtCall5(glGetActiveUniformNamePtr, vbEmpty, program, uniformIndex, bufSize, VarPtr(length), uniformName): End Sub
Public Sub glGetActiveUniformsiv(ByVal program As Long, ByVal uniformCount As Long, uniformIndices As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall5(glGetActiveUniformsivPtr, vbEmpty, program, uniformCount, VarPtr(uniformIndices), pname, VarPtr(params)): End Sub
Public Sub glGetIntegeri_v(ByVal target As Long, ByVal index As Long, data As Long): Call OpenGLExtCall3(glGetIntegeri_vPtr, vbEmpty, target, index, VarPtr(data)): End Sub
Public Function glGetUniformBlockIndex(ByVal program As Long, ByVal uniformBlockName) As Long: glGetUniformBlockIndex = OpenGLExtCall2(glGetUniformBlockIndexPtr, vbLong, program, uniformBlockName): End Function
Public Sub glGetUniformIndices(ByVal program As Long, ByVal uniformCount As Long, ByVal uniformNames, uniformIndices As Long): Call OpenGLExtCall4(glGetUniformIndicesPtr, vbEmpty, program, uniformCount, uniformNames, VarPtr(uniformIndices)): End Sub
Public Sub glUniformBlockBinding(ByVal program As Long, ByVal uniformBlockIndex As Long, ByVal uniformBlockBinding As Long): Call OpenGLExtCall3(glUniformBlockBindingPtr, vbEmpty, program, uniformBlockIndex, uniformBlockBinding): End Sub
'------------------------------- GL_ARB_vertex_array_bgra -------------------------------
'------------------------------- GL_ARB_vertex_array_object -------------------------------
Public Sub glBindVertexArrayARB(ByVal parray As Long): Call OpenGLExtCall1(glBindVertexArrayARBPtr, vbEmpty, parray): End Sub
Public Sub glDeleteVertexArraysARB(ByVal n As Long, arrays As Long): Call OpenGLExtCall2(glDeleteVertexArraysARBPtr, vbEmpty, n, VarPtr(arrays)): End Sub
Public Sub glGenVertexArraysARB(ByVal n As Long, arrays As Long): Call OpenGLExtCall2(glGenVertexArraysARBPtr, vbEmpty, n, VarPtr(arrays)): End Sub
Public Function glIsVertexArrayARB(ByVal parray As Long) As Integer: glIsVertexArrayARB = OpenGLExtCall1(glIsVertexArrayARBPtr, vbInteger, parray): End Function
'------------------------------- GL_ARB_vertex_attrib_64bit -------------------------------
Public Sub glGetVertexAttribLdv(ByVal index As Long, ByVal pname As Long, params As Double): Call OpenGLExtCall3(glGetVertexAttribLdvPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Sub glVertexAttribL1d(ByVal index As Long, ByVal X As Double): Call OpenGLExtCall2(glVertexAttribL1dPtr, vbEmpty, index, X): End Sub
Public Sub glVertexAttribL1dv(ByVal index As Long, v As Double): Call OpenGLExtCall2(glVertexAttribL1dvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttribL2d(ByVal index As Long, ByVal X As Double, ByVal y As Double): Call OpenGLExtCall3(glVertexAttribL2dPtr, vbEmpty, index, X, y): End Sub
Public Sub glVertexAttribL2dv(ByVal index As Long, v As Double): Call OpenGLExtCall2(glVertexAttribL2dvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttribL3d(ByVal index As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double): Call OpenGLExtCall4(glVertexAttribL3dPtr, vbEmpty, index, X, y, z): End Sub
Public Sub glVertexAttribL3dv(ByVal index As Long, v As Double): Call OpenGLExtCall2(glVertexAttribL3dvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttribL4d(ByVal index As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double, ByVal w As Double): Call OpenGLExtCall5(glVertexAttribL4dPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttribL4dv(ByVal index As Long, v As Double): Call OpenGLExtCall2(glVertexAttribL4dvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttribLPointer(ByVal index As Long, ByVal size As Long, ByVal ptype As Long, ByVal stride As Long, ByVal pointer): Call OpenGLExtCall5(glVertexAttribLPointerPtr, vbEmpty, index, size, ptype, stride, pointer): End Sub
'------------------------------- GL_ARB_vertex_attrib_binding -------------------------------
Public Sub glBindVertexBuffer(ByVal bindingindex As Long, ByVal buffer As Long, ByVal offset, ByVal stride As Long): Call OpenGLExtCall4(glBindVertexBufferPtr, vbEmpty, bindingindex, buffer, offset, stride): End Sub
Public Sub glVertexArrayBindVertexBufferEXT(ByVal vaobj As Long, ByVal bindingindex As Long, ByVal buffer As Long, ByVal offset, ByVal stride As Long): Call OpenGLExtCall5(glVertexArrayBindVertexBufferEXTPtr, vbEmpty, vaobj, bindingindex, buffer, offset, stride): End Sub
Public Sub glVertexArrayVertexAttribBindingEXT(ByVal vaobj As Long, ByVal attribindex As Long, ByVal bindingindex As Long): Call OpenGLExtCall3(glVertexArrayVertexAttribBindingEXTPtr, vbEmpty, vaobj, attribindex, bindingindex): End Sub
Public Sub glVertexArrayVertexAttribFormatEXT(ByVal vaobj As Long, ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal relativeoffset As Long): Call OpenGLExtCall6(glVertexArrayVertexAttribFormatEXTPtr, vbEmpty, vaobj, attribindex, size, ptype, normalized, relativeoffset): End Sub
Public Sub glVertexArrayVertexAttribIFormatEXT(ByVal vaobj As Long, ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal relativeoffset As Long): Call OpenGLExtCall5(glVertexArrayVertexAttribIFormatEXTPtr, vbEmpty, vaobj, attribindex, size, ptype, relativeoffset): End Sub
Public Sub glVertexArrayVertexAttribLFormatEXT(ByVal vaobj As Long, ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal relativeoffset As Long): Call OpenGLExtCall5(glVertexArrayVertexAttribLFormatEXTPtr, vbEmpty, vaobj, attribindex, size, ptype, relativeoffset): End Sub
Public Sub glVertexArrayVertexBindingDivisorEXT(ByVal vaobj As Long, ByVal bindingindex As Long, ByVal divisor As Long): Call OpenGLExtCall3(glVertexArrayVertexBindingDivisorEXTPtr, vbEmpty, vaobj, bindingindex, divisor): End Sub
Public Sub glVertexAttribBinding(ByVal attribindex As Long, ByVal bindingindex As Long): Call OpenGLExtCall2(glVertexAttribBindingPtr, vbEmpty, attribindex, bindingindex): End Sub
Public Sub glVertexAttribFormat(ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal relativeoffset As Long): Call OpenGLExtCall5(glVertexAttribFormatPtr, vbEmpty, attribindex, size, ptype, normalized, relativeoffset): End Sub
Public Sub glVertexAttribIFormat(ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal relativeoffset As Long): Call OpenGLExtCall4(glVertexAttribIFormatPtr, vbEmpty, attribindex, size, ptype, relativeoffset): End Sub
Public Sub glVertexAttribLFormat(ByVal attribindex As Long, ByVal size As Long, ByVal ptype As Long, ByVal relativeoffset As Long): Call OpenGLExtCall4(glVertexAttribLFormatPtr, vbEmpty, attribindex, size, ptype, relativeoffset): End Sub
Public Sub glVertexBindingDivisor(ByVal bindingindex As Long, ByVal divisor As Long): Call OpenGLExtCall2(glVertexBindingDivisorPtr, vbEmpty, bindingindex, divisor): End Sub
'------------------------------- GL_ARB_vertex_blend -------------------------------
Public Sub glVertexBlendARB(ByVal count As Long): Call OpenGLExtCall1(glVertexBlendARBPtr, vbEmpty, count): End Sub
Public Sub glWeightPointerARB(ByVal size As Long, ByVal ptype As Long, ByVal stride As Long, ByVal pointer): Call OpenGLExtCall4(glWeightPointerARBPtr, vbEmpty, size, ptype, stride, pointer): End Sub
Public Sub glWeightbvARB(ByVal size As Long, weights As Byte): Call OpenGLExtCall2(glWeightbvARBPtr, vbEmpty, size, VarPtr(weights)): End Sub
Public Sub glWeightdvARB(ByVal size As Long, weights As Double): Call OpenGLExtCall2(glWeightdvARBPtr, vbEmpty, size, VarPtr(weights)): End Sub
Public Sub glWeightfvARB(ByVal size As Long, weights As Single): Call OpenGLExtCall2(glWeightfvARBPtr, vbEmpty, size, VarPtr(weights)): End Sub
Public Sub glWeightivARB(ByVal size As Long, weights As Long): Call OpenGLExtCall2(glWeightivARBPtr, vbEmpty, size, VarPtr(weights)): End Sub
Public Sub glWeightsvARB(ByVal size As Long, weights As Integer): Call OpenGLExtCall2(glWeightsvARBPtr, vbEmpty, size, VarPtr(weights)): End Sub
Public Sub glWeightubvARB(ByVal size As Long, weights As Byte): Call OpenGLExtCall2(glWeightubvARBPtr, vbEmpty, size, VarPtr(weights)): End Sub
Public Sub glWeightuivARB(ByVal size As Long, weights As Long): Call OpenGLExtCall2(glWeightuivARBPtr, vbEmpty, size, VarPtr(weights)): End Sub
Public Sub glWeightusvARB(ByVal size As Long, weights As Long): Call OpenGLExtCall2(glWeightusvARBPtr, vbEmpty, size, VarPtr(weights)): End Sub
'------------------------------- GL_ARB_vertex_buffer_object -------------------------------
Public Sub glBindBufferARB(ByVal target As Long, ByVal buffer As Long): Call OpenGLExtCall2(glBindBufferARBPtr, vbEmpty, target, buffer): End Sub
Public Sub glBufferDataARB(ByVal target As Long, ByVal size, ByVal data, ByVal usage As Long): Call OpenGLExtCall4(glBufferDataARBPtr, vbEmpty, target, size, data, usage): End Sub
Public Sub glBufferSubDataARB(ByVal target As Long, ByVal offset, ByVal size, ByVal data): Call OpenGLExtCall4(glBufferSubDataARBPtr, vbEmpty, target, offset, size, data): End Sub
Public Sub glDeleteBuffersARB(ByVal n As Long, buffers As Long): Call OpenGLExtCall2(glDeleteBuffersARBPtr, vbEmpty, n, VarPtr(buffers)): End Sub
Public Sub glGenBuffersARB(ByVal n As Long, buffers As Long): Call OpenGLExtCall2(glGenBuffersARBPtr, vbEmpty, n, VarPtr(buffers)): End Sub
Public Sub glGetBufferParameterivARB(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetBufferParameterivARBPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetBufferPointervARB(ByVal target As Long, ByVal pname As Long, ByVal params): Call OpenGLExtCall3(glGetBufferPointervARBPtr, vbEmpty, target, pname, params): End Sub
Public Sub glGetBufferSubDataARB(ByVal target As Long, ByVal offset, ByVal size, ByVal data): Call OpenGLExtCall4(glGetBufferSubDataARBPtr, vbEmpty, target, offset, size, data): End Sub
Public Function glIsBufferARB(ByVal buffer As Long) As Integer: glIsBufferARB = OpenGLExtCall1(glIsBufferARBPtr, vbInteger, buffer): End Function
Public Function glUnmapBufferARB(ByVal target As Long) As Integer: glUnmapBufferARB = OpenGLExtCall1(glUnmapBufferARBPtr, vbInteger, target): End Function
'------------------------------- GL_ARB_vertex_program -------------------------------
Public Sub glBindProgramARB(ByVal target As Long, ByVal program As Long): Call OpenGLExtCall2(glBindProgramARBPtr, vbEmpty, target, program): End Sub
Public Sub glDeleteProgramsARB(ByVal n As Long, programs As Long): Call OpenGLExtCall2(glDeleteProgramsARBPtr, vbEmpty, n, VarPtr(programs)): End Sub
Public Sub glDisableVertexAttribArrayARB(ByVal index As Long): Call OpenGLExtCall1(glDisableVertexAttribArrayARBPtr, vbEmpty, index): End Sub
Public Sub glEnableVertexAttribArrayARB(ByVal index As Long): Call OpenGLExtCall1(glEnableVertexAttribArrayARBPtr, vbEmpty, index): End Sub
Public Sub glGenProgramsARB(ByVal n As Long, programs As Long): Call OpenGLExtCall2(glGenProgramsARBPtr, vbEmpty, n, VarPtr(programs)): End Sub
Public Sub glGetProgramEnvParameterdvARB(ByVal target As Long, ByVal index As Long, params As Double): Call OpenGLExtCall3(glGetProgramEnvParameterdvARBPtr, vbEmpty, target, index, VarPtr(params)): End Sub
Public Sub glGetProgramEnvParameterfvARB(ByVal target As Long, ByVal index As Long, params As Single): Call OpenGLExtCall3(glGetProgramEnvParameterfvARBPtr, vbEmpty, target, index, VarPtr(params)): End Sub
Public Sub glGetProgramLocalParameterdvARB(ByVal target As Long, ByVal index As Long, params As Double): Call OpenGLExtCall3(glGetProgramLocalParameterdvARBPtr, vbEmpty, target, index, VarPtr(params)): End Sub
Public Sub glGetProgramLocalParameterfvARB(ByVal target As Long, ByVal index As Long, params As Single): Call OpenGLExtCall3(glGetProgramLocalParameterfvARBPtr, vbEmpty, target, index, VarPtr(params)): End Sub
Public Sub glGetProgramStringARB(ByVal target As Long, ByVal pname As Long, ByVal pstring): Call OpenGLExtCall3(glGetProgramStringARBPtr, vbEmpty, target, pname, pstring): End Sub
Public Sub glGetProgramivARB(ByVal target As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetProgramivARBPtr, vbEmpty, target, pname, VarPtr(params)): End Sub
Public Sub glGetVertexAttribPointervARB(ByVal index As Long, ByVal pname As Long, ByVal pointer): Call OpenGLExtCall3(glGetVertexAttribPointervARBPtr, vbEmpty, index, pname, pointer): End Sub
Public Sub glGetVertexAttribdvARB(ByVal index As Long, ByVal pname As Long, params As Double): Call OpenGLExtCall3(glGetVertexAttribdvARBPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Sub glGetVertexAttribfvARB(ByVal index As Long, ByVal pname As Long, params As Single): Call OpenGLExtCall3(glGetVertexAttribfvARBPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Sub glGetVertexAttribivARB(ByVal index As Long, ByVal pname As Long, params As Long): Call OpenGLExtCall3(glGetVertexAttribivARBPtr, vbEmpty, index, pname, VarPtr(params)): End Sub
Public Function glIsProgramARB(ByVal program As Long) As Integer: glIsProgramARB = OpenGLExtCall1(glIsProgramARBPtr, vbInteger, program): End Function
Public Sub glProgramEnvParameter4dARB(ByVal target As Long, ByVal index As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double, ByVal w As Double): Call OpenGLExtCall6(glProgramEnvParameter4dARBPtr, vbEmpty, target, index, X, y, z, w): End Sub
Public Sub glProgramEnvParameter4dvARB(ByVal target As Long, ByVal index As Long, params As Double): Call OpenGLExtCall3(glProgramEnvParameter4dvARBPtr, vbEmpty, target, index, VarPtr(params)): End Sub
Public Sub glProgramEnvParameter4fARB(ByVal target As Long, ByVal index As Long, ByVal X As Single, ByVal y As Single, ByVal z As Single, ByVal w As Single): Call OpenGLExtCall6(glProgramEnvParameter4fARBPtr, vbEmpty, target, index, X, y, z, w): End Sub
Public Sub glProgramEnvParameter4fvARB(ByVal target As Long, ByVal index As Long, params As Single): Call OpenGLExtCall3(glProgramEnvParameter4fvARBPtr, vbEmpty, target, index, VarPtr(params)): End Sub
Public Sub glProgramLocalParameter4dARB(ByVal target As Long, ByVal index As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double, ByVal w As Double): Call OpenGLExtCall6(glProgramLocalParameter4dARBPtr, vbEmpty, target, index, X, y, z, w): End Sub
Public Sub glProgramLocalParameter4dvARB(ByVal target As Long, ByVal index As Long, params As Double): Call OpenGLExtCall3(glProgramLocalParameter4dvARBPtr, vbEmpty, target, index, VarPtr(params)): End Sub
Public Sub glProgramLocalParameter4fARB(ByVal target As Long, ByVal index As Long, ByVal X As Single, ByVal y As Single, ByVal z As Single, ByVal w As Single): Call OpenGLExtCall6(glProgramLocalParameter4fARBPtr, vbEmpty, target, index, X, y, z, w): End Sub
Public Sub glProgramLocalParameter4fvARB(ByVal target As Long, ByVal index As Long, params As Single): Call OpenGLExtCall3(glProgramLocalParameter4fvARBPtr, vbEmpty, target, index, VarPtr(params)): End Sub
Public Sub glProgramStringARB(ByVal target As Long, ByVal format As Long, ByVal plen As Long, ByVal pstring): Call OpenGLExtCall4(glProgramStringARBPtr, vbEmpty, target, format, plen, pstring): End Sub
Public Sub glVertexAttrib1dARB(ByVal index As Long, ByVal X As Double): Call OpenGLExtCall2(glVertexAttrib1dARBPtr, vbEmpty, index, X): End Sub
Public Sub glVertexAttrib1dvARB(ByVal index As Long, v As Double): Call OpenGLExtCall2(glVertexAttrib1dvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib1fARB(ByVal index As Long, ByVal X As Single): Call OpenGLExtCall2(glVertexAttrib1fARBPtr, vbEmpty, index, X): End Sub
Public Sub glVertexAttrib1fvARB(ByVal index As Long, v As Single): Call OpenGLExtCall2(glVertexAttrib1fvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib1sARB(ByVal index As Long, ByVal X As Integer): Call OpenGLExtCall2(glVertexAttrib1sARBPtr, vbEmpty, index, X): End Sub
Public Sub glVertexAttrib1svARB(ByVal index As Long, v As Integer): Call OpenGLExtCall2(glVertexAttrib1svARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib2dARB(ByVal index As Long, ByVal X As Double, ByVal y As Double): Call OpenGLExtCall3(glVertexAttrib2dARBPtr, vbEmpty, index, X, y): End Sub
Public Sub glVertexAttrib2dvARB(ByVal index As Long, v As Double): Call OpenGLExtCall2(glVertexAttrib2dvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib2fARB(ByVal index As Long, ByVal X As Single, ByVal y As Single): Call OpenGLExtCall3(glVertexAttrib2fARBPtr, vbEmpty, index, X, y): End Sub
Public Sub glVertexAttrib2fvARB(ByVal index As Long, v As Single): Call OpenGLExtCall2(glVertexAttrib2fvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib2sARB(ByVal index As Long, ByVal X As Integer, ByVal y As Integer): Call OpenGLExtCall3(glVertexAttrib2sARBPtr, vbEmpty, index, X, y): End Sub
Public Sub glVertexAttrib2svARB(ByVal index As Long, v As Integer): Call OpenGLExtCall2(glVertexAttrib2svARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib3dARB(ByVal index As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double): Call OpenGLExtCall4(glVertexAttrib3dARBPtr, vbEmpty, index, X, y, z): End Sub
Public Sub glVertexAttrib3dvARB(ByVal index As Long, v As Double): Call OpenGLExtCall2(glVertexAttrib3dvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib3fARB(ByVal index As Long, ByVal X As Single, ByVal y As Single, ByVal z As Single): Call OpenGLExtCall4(glVertexAttrib3fARBPtr, vbEmpty, index, X, y, z): End Sub
Public Sub glVertexAttrib3fvARB(ByVal index As Long, v As Single): Call OpenGLExtCall2(glVertexAttrib3fvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib3sARB(ByVal index As Long, ByVal X As Integer, ByVal y As Integer, ByVal z As Integer): Call OpenGLExtCall4(glVertexAttrib3sARBPtr, vbEmpty, index, X, y, z): End Sub
Public Sub glVertexAttrib3svARB(ByVal index As Long, v As Integer): Call OpenGLExtCall2(glVertexAttrib3svARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4NbvARB(ByVal index As Long, v As Byte): Call OpenGLExtCall2(glVertexAttrib4NbvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4NivARB(ByVal index As Long, v As Long): Call OpenGLExtCall2(glVertexAttrib4NivARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4NsvARB(ByVal index As Long, v As Integer): Call OpenGLExtCall2(glVertexAttrib4NsvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4NubARB(ByVal index As Long, ByVal X As Byte, ByVal y As Byte, ByVal z As Byte, ByVal w As Byte): Call OpenGLExtCall5(glVertexAttrib4NubARBPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttrib4NubvARB(ByVal index As Long, v As Byte): Call OpenGLExtCall2(glVertexAttrib4NubvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4NuivARB(ByVal index As Long, v As Long): Call OpenGLExtCall2(glVertexAttrib4NuivARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4NusvARB(ByVal index As Long, v As Long): Call OpenGLExtCall2(glVertexAttrib4NusvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4bvARB(ByVal index As Long, v As Byte): Call OpenGLExtCall2(glVertexAttrib4bvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4dARB(ByVal index As Long, ByVal X As Double, ByVal y As Double, ByVal z As Double, ByVal w As Double): Call OpenGLExtCall5(glVertexAttrib4dARBPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttrib4dvARB(ByVal index As Long, v As Double): Call OpenGLExtCall2(glVertexAttrib4dvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4fARB(ByVal index As Long, ByVal X As Single, ByVal y As Single, ByVal z As Single, ByVal w As Single): Call OpenGLExtCall5(glVertexAttrib4fARBPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttrib4fvARB(ByVal index As Long, v As Single): Call OpenGLExtCall2(glVertexAttrib4fvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4ivARB(ByVal index As Long, v As Long): Call OpenGLExtCall2(glVertexAttrib4ivARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4sARB(ByVal index As Long, ByVal X As Integer, ByVal y As Integer, ByVal z As Integer, ByVal w As Integer): Call OpenGLExtCall5(glVertexAttrib4sARBPtr, vbEmpty, index, X, y, z, w): End Sub
Public Sub glVertexAttrib4svARB(ByVal index As Long, v As Integer): Call OpenGLExtCall2(glVertexAttrib4svARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4ubvARB(ByVal index As Long, v As Byte): Call OpenGLExtCall2(glVertexAttrib4ubvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4uivARB(ByVal index As Long, v As Long): Call OpenGLExtCall2(glVertexAttrib4uivARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttrib4usvARB(ByVal index As Long, v As Long): Call OpenGLExtCall2(glVertexAttrib4usvARBPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glVertexAttribPointerARB(ByVal index As Long, ByVal size As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal stride As Long, ByVal pointer): Call OpenGLExtCall6(glVertexAttribPointerARBPtr, vbEmpty, index, size, ptype, normalized, stride, pointer): End Sub
'------------------------------- GL_ARB_vertex_shader -------------------------------
Public Sub glBindAttribLocationARB(ByVal programObj, ByVal index As Long, ByVal name): Call OpenGLExtCall3(glBindAttribLocationARBPtr, vbEmpty, programObj, index, name): End Sub
Public Sub glGetActiveAttribARB(ByVal programObj, ByVal index As Long, ByVal maxLength As Long, length As Long, size As Long, ptype As Long, ByVal name): Call OpenGLExtCall7(glGetActiveAttribARBPtr, vbEmpty, programObj, index, maxLength, VarPtr(length), VarPtr(size), VarPtr(ptype), name): End Sub
Public Function glGetAttribLocationARB(ByVal programObj, ByVal name) As Long: glGetAttribLocationARB = OpenGLExtCall2(glGetAttribLocationARBPtr, vbLong, programObj, name): End Function
'------------------------------- GL_ARB_vertex_type_10f_11f_11f_rev -------------------------------
'------------------------------- GL_ARB_vertex_type_2_10_10_10_rev -------------------------------
Public Sub glColorP3ui(ByVal ptype As Long, ByVal color As Long): Call OpenGLExtCall2(glColorP3uiPtr, vbEmpty, ptype, color): End Sub
Public Sub glColorP3uiv(ByVal ptype As Long, color As Long): Call OpenGLExtCall2(glColorP3uivPtr, vbEmpty, ptype, VarPtr(color)): End Sub
Public Sub glColorP4ui(ByVal ptype As Long, ByVal color As Long): Call OpenGLExtCall2(glColorP4uiPtr, vbEmpty, ptype, color): End Sub
Public Sub glColorP4uiv(ByVal ptype As Long, color As Long): Call OpenGLExtCall2(glColorP4uivPtr, vbEmpty, ptype, VarPtr(color)): End Sub
Public Sub glMultiTexCoordP1ui(ByVal texture As Long, ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall3(glMultiTexCoordP1uiPtr, vbEmpty, texture, ptype, coords): End Sub
Public Sub glMultiTexCoordP1uiv(ByVal texture As Long, ByVal ptype As Long, coords As Long): Call OpenGLExtCall3(glMultiTexCoordP1uivPtr, vbEmpty, texture, ptype, VarPtr(coords)): End Sub
Public Sub glMultiTexCoordP2ui(ByVal texture As Long, ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall3(glMultiTexCoordP2uiPtr, vbEmpty, texture, ptype, coords): End Sub
Public Sub glMultiTexCoordP2uiv(ByVal texture As Long, ByVal ptype As Long, coords As Long): Call OpenGLExtCall3(glMultiTexCoordP2uivPtr, vbEmpty, texture, ptype, VarPtr(coords)): End Sub
Public Sub glMultiTexCoordP3ui(ByVal texture As Long, ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall3(glMultiTexCoordP3uiPtr, vbEmpty, texture, ptype, coords): End Sub
Public Sub glMultiTexCoordP3uiv(ByVal texture As Long, ByVal ptype As Long, coords As Long): Call OpenGLExtCall3(glMultiTexCoordP3uivPtr, vbEmpty, texture, ptype, VarPtr(coords)): End Sub
Public Sub glMultiTexCoordP4ui(ByVal texture As Long, ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall3(glMultiTexCoordP4uiPtr, vbEmpty, texture, ptype, coords): End Sub
Public Sub glMultiTexCoordP4uiv(ByVal texture As Long, ByVal ptype As Long, coords As Long): Call OpenGLExtCall3(glMultiTexCoordP4uivPtr, vbEmpty, texture, ptype, VarPtr(coords)): End Sub
Public Sub glNormalP3ui(ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall2(glNormalP3uiPtr, vbEmpty, ptype, coords): End Sub
Public Sub glNormalP3uiv(ByVal ptype As Long, coords As Long): Call OpenGLExtCall2(glNormalP3uivPtr, vbEmpty, ptype, VarPtr(coords)): End Sub
Public Sub glSecondaryColorP3ui(ByVal ptype As Long, ByVal color As Long): Call OpenGLExtCall2(glSecondaryColorP3uiPtr, vbEmpty, ptype, color): End Sub
Public Sub glSecondaryColorP3uiv(ByVal ptype As Long, color As Long): Call OpenGLExtCall2(glSecondaryColorP3uivPtr, vbEmpty, ptype, VarPtr(color)): End Sub
Public Sub glTexCoordP1ui(ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall2(glTexCoordP1uiPtr, vbEmpty, ptype, coords): End Sub
Public Sub glTexCoordP1uiv(ByVal ptype As Long, coords As Long): Call OpenGLExtCall2(glTexCoordP1uivPtr, vbEmpty, ptype, VarPtr(coords)): End Sub
Public Sub glTexCoordP2ui(ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall2(glTexCoordP2uiPtr, vbEmpty, ptype, coords): End Sub
Public Sub glTexCoordP2uiv(ByVal ptype As Long, coords As Long): Call OpenGLExtCall2(glTexCoordP2uivPtr, vbEmpty, ptype, VarPtr(coords)): End Sub
Public Sub glTexCoordP3ui(ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall2(glTexCoordP3uiPtr, vbEmpty, ptype, coords): End Sub
Public Sub glTexCoordP3uiv(ByVal ptype As Long, coords As Long): Call OpenGLExtCall2(glTexCoordP3uivPtr, vbEmpty, ptype, VarPtr(coords)): End Sub
Public Sub glTexCoordP4ui(ByVal ptype As Long, ByVal coords As Long): Call OpenGLExtCall2(glTexCoordP4uiPtr, vbEmpty, ptype, coords): End Sub
Public Sub glTexCoordP4uiv(ByVal ptype As Long, coords As Long): Call OpenGLExtCall2(glTexCoordP4uivPtr, vbEmpty, ptype, VarPtr(coords)): End Sub
Public Sub glVertexAttribP1ui(ByVal index As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal value As Long): Call OpenGLExtCall4(glVertexAttribP1uiPtr, vbEmpty, index, ptype, normalized, value): End Sub
Public Sub glVertexAttribP1uiv(ByVal index As Long, ByVal ptype As Long, ByVal normalized As Integer, value As Long): Call OpenGLExtCall4(glVertexAttribP1uivPtr, vbEmpty, index, ptype, normalized, VarPtr(value)): End Sub
Public Sub glVertexAttribP2ui(ByVal index As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal value As Long): Call OpenGLExtCall4(glVertexAttribP2uiPtr, vbEmpty, index, ptype, normalized, value): End Sub
Public Sub glVertexAttribP2uiv(ByVal index As Long, ByVal ptype As Long, ByVal normalized As Integer, value As Long): Call OpenGLExtCall4(glVertexAttribP2uivPtr, vbEmpty, index, ptype, normalized, VarPtr(value)): End Sub
Public Sub glVertexAttribP3ui(ByVal index As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal value As Long): Call OpenGLExtCall4(glVertexAttribP3uiPtr, vbEmpty, index, ptype, normalized, value): End Sub
Public Sub glVertexAttribP3uiv(ByVal index As Long, ByVal ptype As Long, ByVal normalized As Integer, value As Long): Call OpenGLExtCall4(glVertexAttribP3uivPtr, vbEmpty, index, ptype, normalized, VarPtr(value)): End Sub
Public Sub glVertexAttribP4ui(ByVal index As Long, ByVal ptype As Long, ByVal normalized As Integer, ByVal value As Long): Call OpenGLExtCall4(glVertexAttribP4uiPtr, vbEmpty, index, ptype, normalized, value): End Sub
Public Sub glVertexAttribP4uiv(ByVal index As Long, ByVal ptype As Long, ByVal normalized As Integer, value As Long): Call OpenGLExtCall4(glVertexAttribP4uivPtr, vbEmpty, index, ptype, normalized, VarPtr(value)): End Sub
Public Sub glVertexP2ui(ByVal ptype As Long, ByVal value As Long): Call OpenGLExtCall2(glVertexP2uiPtr, vbEmpty, ptype, value): End Sub
Public Sub glVertexP2uiv(ByVal ptype As Long, value As Long): Call OpenGLExtCall2(glVertexP2uivPtr, vbEmpty, ptype, VarPtr(value)): End Sub
Public Sub glVertexP3ui(ByVal ptype As Long, ByVal value As Long): Call OpenGLExtCall2(glVertexP3uiPtr, vbEmpty, ptype, value): End Sub
Public Sub glVertexP3uiv(ByVal ptype As Long, value As Long): Call OpenGLExtCall2(glVertexP3uivPtr, vbEmpty, ptype, VarPtr(value)): End Sub
Public Sub glVertexP4ui(ByVal ptype As Long, ByVal value As Long): Call OpenGLExtCall2(glVertexP4uiPtr, vbEmpty, ptype, value): End Sub
Public Sub glVertexP4uiv(ByVal ptype As Long, value As Long): Call OpenGLExtCall2(glVertexP4uivPtr, vbEmpty, ptype, VarPtr(value)): End Sub
'------------------------------- GL_ARB_viewport_array -------------------------------
Public Sub glDepthRangeArrayv(ByVal first As Long, ByVal count As Long, v As Double): Call OpenGLExtCall3(glDepthRangeArrayvPtr, vbEmpty, first, count, VarPtr(v)): End Sub
Public Sub glDepthRangeIndexed(ByVal index As Long, ByVal n As Double, ByVal f As Double): Call OpenGLExtCall3(glDepthRangeIndexedPtr, vbEmpty, index, n, f): End Sub
Public Sub glGetDoublei_v(ByVal target As Long, ByVal index As Long, data As Double): Call OpenGLExtCall3(glGetDoublei_vPtr, vbEmpty, target, index, VarPtr(data)): End Sub
Public Sub glGetFloati_v(ByVal target As Long, ByVal index As Long, data As Single): Call OpenGLExtCall3(glGetFloati_vPtr, vbEmpty, target, index, VarPtr(data)): End Sub
Public Sub glScissorArrayv(ByVal first As Long, ByVal count As Long, v As Long): Call OpenGLExtCall3(glScissorArrayvPtr, vbEmpty, first, count, VarPtr(v)): End Sub
Public Sub glScissorIndexed(ByVal index As Long, ByVal Left As Long, ByVal Bottom As Long, ByVal Width As Long, ByVal Height As Long): Call OpenGLExtCall5(glScissorIndexedPtr, vbEmpty, index, Left, Bottom, Width, Height): End Sub
Public Sub glScissorIndexedv(ByVal index As Long, v As Long): Call OpenGLExtCall2(glScissorIndexedvPtr, vbEmpty, index, VarPtr(v)): End Sub
Public Sub glViewportArrayv(ByVal first As Long, ByVal count As Long, v As Single): Call OpenGLExtCall3(glViewportArrayvPtr, vbEmpty, first, count, VarPtr(v)): End Sub
Public Sub glViewportIndexedf(ByVal index As Long, ByVal X As Single, ByVal y As Single, ByVal w As Single, ByVal h As Single): Call OpenGLExtCall5(glViewportIndexedfPtr, vbEmpty, index, X, y, w, h): End Sub
Public Sub glViewportIndexedfv(ByVal index As Long, v As Single): Call OpenGLExtCall2(glViewportIndexedfvPtr, vbEmpty, index, VarPtr(v)): End Sub
'------------------------------- GL_ARB_window_pos -------------------------------
Public Sub glWindowPos2dARB(ByVal X As Double, ByVal y As Double): Call OpenGLExtCall2(glWindowPos2dARBPtr, vbEmpty, X, y): End Sub
Public Sub glWindowPos2dvARB(p As Double): Call OpenGLExtCall1(glWindowPos2dvARBPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos2fARB(ByVal X As Single, ByVal y As Single): Call OpenGLExtCall2(glWindowPos2fARBPtr, vbEmpty, X, y): End Sub
Public Sub glWindowPos2fvARB(p As Single): Call OpenGLExtCall1(glWindowPos2fvARBPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos2iARB(ByVal X As Long, ByVal y As Long): Call OpenGLExtCall2(glWindowPos2iARBPtr, vbEmpty, X, y): End Sub
Public Sub glWindowPos2ivARB(p As Long): Call OpenGLExtCall1(glWindowPos2ivARBPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos2sARB(ByVal X As Integer, ByVal y As Integer): Call OpenGLExtCall2(glWindowPos2sARBPtr, vbEmpty, X, y): End Sub
Public Sub glWindowPos2svARB(p As Integer): Call OpenGLExtCall1(glWindowPos2svARBPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos3dARB(ByVal X As Double, ByVal y As Double, ByVal z As Double): Call OpenGLExtCall3(glWindowPos3dARBPtr, vbEmpty, X, y, z): End Sub
Public Sub glWindowPos3dvARB(p As Double): Call OpenGLExtCall1(glWindowPos3dvARBPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos3fARB(ByVal X As Single, ByVal y As Single, ByVal z As Single): Call OpenGLExtCall3(glWindowPos3fARBPtr, vbEmpty, X, y, z): End Sub
Public Sub glWindowPos3fvARB(p As Single): Call OpenGLExtCall1(glWindowPos3fvARBPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos3iARB(ByVal X As Long, ByVal y As Long, ByVal z As Long): Call OpenGLExtCall3(glWindowPos3iARBPtr, vbEmpty, X, y, z): End Sub
Public Sub glWindowPos3ivARB(p As Long): Call OpenGLExtCall1(glWindowPos3ivARBPtr, vbEmpty, VarPtr(p)): End Sub
Public Sub glWindowPos3sARB(ByVal X As Integer, ByVal y As Integer, ByVal z As Integer): Call OpenGLExtCall3(glWindowPos3sARBPtr, vbEmpty, X, y, z): End Sub
Public Sub glWindowPos3svARB(p As Integer): Call OpenGLExtCall1(glWindowPos3svARBPtr, vbEmpty, VarPtr(p)): End Sub
'***************************************************************************************
'*                                      Remap                                          *
'***************************************************************************************
Public Function RemapVBToGLARB()
If IsDEPEnabled Then
    glWindowPos3svARBPtr = OpenGLExtProcAddress("glWindowPos3svARB")
    glWindowPos3sARBPtr = OpenGLExtProcAddress("glWindowPos3sARB")
    glWindowPos3ivARBPtr = OpenGLExtProcAddress("glWindowPos3ivARB")
    glWindowPos3iARBPtr = OpenGLExtProcAddress("glWindowPos3iARB")
    glWindowPos3fvARBPtr = OpenGLExtProcAddress("glWindowPos3fvARB")
    glWindowPos3fARBPtr = OpenGLExtProcAddress("glWindowPos3fARB")
    glWindowPos3dvARBPtr = OpenGLExtProcAddress("glWindowPos3dvARB")
    glWindowPos3dARBPtr = OpenGLExtProcAddress("glWindowPos3dARB")
    glWindowPos2svARBPtr = OpenGLExtProcAddress("glWindowPos2svARB")
    glWindowPos2sARBPtr = OpenGLExtProcAddress("glWindowPos2sARB")
    glWindowPos2ivARBPtr = OpenGLExtProcAddress("glWindowPos2ivARB")
    glWindowPos2iARBPtr = OpenGLExtProcAddress("glWindowPos2iARB")
    glWindowPos2fvARBPtr = OpenGLExtProcAddress("glWindowPos2fvARB")
    glWindowPos2fARBPtr = OpenGLExtProcAddress("glWindowPos2fARB")
    glWindowPos2dvARBPtr = OpenGLExtProcAddress("glWindowPos2dvARB")
    glWindowPos2dARBPtr = OpenGLExtProcAddress("glWindowPos2dARB")
    glViewportIndexedfvPtr = OpenGLExtProcAddress("glViewportIndexedfv")
    glViewportIndexedfPtr = OpenGLExtProcAddress("glViewportIndexedf")
    glViewportArrayvPtr = OpenGLExtProcAddress("glViewportArrayv")
    glScissorIndexedvPtr = OpenGLExtProcAddress("glScissorIndexedv")
    glScissorIndexedPtr = OpenGLExtProcAddress("glScissorIndexed")
    glScissorArrayvPtr = OpenGLExtProcAddress("glScissorArrayv")
    glGetFloati_vPtr = OpenGLExtProcAddress("glGetFloati_v")
    glGetDoublei_vPtr = OpenGLExtProcAddress("glGetDoublei_v")
    glDepthRangeIndexedPtr = OpenGLExtProcAddress("glDepthRangeIndexed")
    glDepthRangeArrayvPtr = OpenGLExtProcAddress("glDepthRangeArrayv")
    glVertexP4uivPtr = OpenGLExtProcAddress("glVertexP4uiv")
    glVertexP4uiPtr = OpenGLExtProcAddress("glVertexP4ui")
    glVertexP3uivPtr = OpenGLExtProcAddress("glVertexP3uiv")
    glVertexP3uiPtr = OpenGLExtProcAddress("glVertexP3ui")
    glVertexP2uivPtr = OpenGLExtProcAddress("glVertexP2uiv")
    glVertexP2uiPtr = OpenGLExtProcAddress("glVertexP2ui")
    glVertexAttribP4uivPtr = OpenGLExtProcAddress("glVertexAttribP4uiv")
    glVertexAttribP4uiPtr = OpenGLExtProcAddress("glVertexAttribP4ui")
    glVertexAttribP3uivPtr = OpenGLExtProcAddress("glVertexAttribP3uiv")
    glVertexAttribP3uiPtr = OpenGLExtProcAddress("glVertexAttribP3ui")
    glVertexAttribP2uivPtr = OpenGLExtProcAddress("glVertexAttribP2uiv")
    glVertexAttribP2uiPtr = OpenGLExtProcAddress("glVertexAttribP2ui")
    glVertexAttribP1uivPtr = OpenGLExtProcAddress("glVertexAttribP1uiv")
    glVertexAttribP1uiPtr = OpenGLExtProcAddress("glVertexAttribP1ui")
    glTexCoordP4uivPtr = OpenGLExtProcAddress("glTexCoordP4uiv")
    glTexCoordP4uiPtr = OpenGLExtProcAddress("glTexCoordP4ui")
    glTexCoordP3uivPtr = OpenGLExtProcAddress("glTexCoordP3uiv")
    glTexCoordP3uiPtr = OpenGLExtProcAddress("glTexCoordP3ui")
    glTexCoordP2uivPtr = OpenGLExtProcAddress("glTexCoordP2uiv")
    glTexCoordP2uiPtr = OpenGLExtProcAddress("glTexCoordP2ui")
    glTexCoordP1uivPtr = OpenGLExtProcAddress("glTexCoordP1uiv")
    glTexCoordP1uiPtr = OpenGLExtProcAddress("glTexCoordP1ui")
    glSecondaryColorP3uivPtr = OpenGLExtProcAddress("glSecondaryColorP3uiv")
    glSecondaryColorP3uiPtr = OpenGLExtProcAddress("glSecondaryColorP3ui")
    glNormalP3uivPtr = OpenGLExtProcAddress("glNormalP3uiv")
    glNormalP3uiPtr = OpenGLExtProcAddress("glNormalP3ui")
    glMultiTexCoordP4uivPtr = OpenGLExtProcAddress("glMultiTexCoordP4uiv")
    glMultiTexCoordP4uiPtr = OpenGLExtProcAddress("glMultiTexCoordP4ui")
    glMultiTexCoordP3uivPtr = OpenGLExtProcAddress("glMultiTexCoordP3uiv")
    glMultiTexCoordP3uiPtr = OpenGLExtProcAddress("glMultiTexCoordP3ui")
    glMultiTexCoordP2uivPtr = OpenGLExtProcAddress("glMultiTexCoordP2uiv")
    glMultiTexCoordP2uiPtr = OpenGLExtProcAddress("glMultiTexCoordP2ui")
    glMultiTexCoordP1uivPtr = OpenGLExtProcAddress("glMultiTexCoordP1uiv")
    glMultiTexCoordP1uiPtr = OpenGLExtProcAddress("glMultiTexCoordP1ui")
    glColorP4uivPtr = OpenGLExtProcAddress("glColorP4uiv")
    glColorP4uiPtr = OpenGLExtProcAddress("glColorP4ui")
    glColorP3uivPtr = OpenGLExtProcAddress("glColorP3uiv")
    glColorP3uiPtr = OpenGLExtProcAddress("glColorP3ui")
    glGetAttribLocationARBPtr = OpenGLExtProcAddress("glGetAttribLocationARB")
    glGetActiveAttribARBPtr = OpenGLExtProcAddress("glGetActiveAttribARB")
    glBindAttribLocationARBPtr = OpenGLExtProcAddress("glBindAttribLocationARB")
    glVertexAttribPointerARBPtr = OpenGLExtProcAddress("glVertexAttribPointerARB")
    glVertexAttrib4usvARBPtr = OpenGLExtProcAddress("glVertexAttrib4usvARB")
    glVertexAttrib4uivARBPtr = OpenGLExtProcAddress("glVertexAttrib4uivARB")
    glVertexAttrib4ubvARBPtr = OpenGLExtProcAddress("glVertexAttrib4ubvARB")
    glVertexAttrib4svARBPtr = OpenGLExtProcAddress("glVertexAttrib4svARB")
    glVertexAttrib4sARBPtr = OpenGLExtProcAddress("glVertexAttrib4sARB")
    glVertexAttrib4ivARBPtr = OpenGLExtProcAddress("glVertexAttrib4ivARB")
    glVertexAttrib4fvARBPtr = OpenGLExtProcAddress("glVertexAttrib4fvARB")
    glVertexAttrib4fARBPtr = OpenGLExtProcAddress("glVertexAttrib4fARB")
    glVertexAttrib4dvARBPtr = OpenGLExtProcAddress("glVertexAttrib4dvARB")
    glVertexAttrib4dARBPtr = OpenGLExtProcAddress("glVertexAttrib4dARB")
    glVertexAttrib4bvARBPtr = OpenGLExtProcAddress("glVertexAttrib4bvARB")
    glVertexAttrib4NusvARBPtr = OpenGLExtProcAddress("glVertexAttrib4NusvARB")
    glVertexAttrib4NuivARBPtr = OpenGLExtProcAddress("glVertexAttrib4NuivARB")
    glVertexAttrib4NubvARBPtr = OpenGLExtProcAddress("glVertexAttrib4NubvARB")
    glVertexAttrib4NubARBPtr = OpenGLExtProcAddress("glVertexAttrib4NubARB")
    glVertexAttrib4NsvARBPtr = OpenGLExtProcAddress("glVertexAttrib4NsvARB")
    glVertexAttrib4NivARBPtr = OpenGLExtProcAddress("glVertexAttrib4NivARB")
    glVertexAttrib4NbvARBPtr = OpenGLExtProcAddress("glVertexAttrib4NbvARB")
    glVertexAttrib3svARBPtr = OpenGLExtProcAddress("glVertexAttrib3svARB")
    glVertexAttrib3sARBPtr = OpenGLExtProcAddress("glVertexAttrib3sARB")
    glVertexAttrib3fvARBPtr = OpenGLExtProcAddress("glVertexAttrib3fvARB")
    glVertexAttrib3fARBPtr = OpenGLExtProcAddress("glVertexAttrib3fARB")
    glVertexAttrib3dvARBPtr = OpenGLExtProcAddress("glVertexAttrib3dvARB")
    glVertexAttrib3dARBPtr = OpenGLExtProcAddress("glVertexAttrib3dARB")
    glVertexAttrib2svARBPtr = OpenGLExtProcAddress("glVertexAttrib2svARB")
    glVertexAttrib2sARBPtr = OpenGLExtProcAddress("glVertexAttrib2sARB")
    glVertexAttrib2fvARBPtr = OpenGLExtProcAddress("glVertexAttrib2fvARB")
    glVertexAttrib2fARBPtr = OpenGLExtProcAddress("glVertexAttrib2fARB")
    glVertexAttrib2dvARBPtr = OpenGLExtProcAddress("glVertexAttrib2dvARB")
    glVertexAttrib2dARBPtr = OpenGLExtProcAddress("glVertexAttrib2dARB")
    glVertexAttrib1svARBPtr = OpenGLExtProcAddress("glVertexAttrib1svARB")
    glVertexAttrib1sARBPtr = OpenGLExtProcAddress("glVertexAttrib1sARB")
    glVertexAttrib1fvARBPtr = OpenGLExtProcAddress("glVertexAttrib1fvARB")
    glVertexAttrib1fARBPtr = OpenGLExtProcAddress("glVertexAttrib1fARB")
    glVertexAttrib1dvARBPtr = OpenGLExtProcAddress("glVertexAttrib1dvARB")
    glVertexAttrib1dARBPtr = OpenGLExtProcAddress("glVertexAttrib1dARB")
    glProgramStringARBPtr = OpenGLExtProcAddress("glProgramStringARB")
    glProgramLocalParameter4fvARBPtr = OpenGLExtProcAddress("glProgramLocalParameter4fvARB")
    glProgramLocalParameter4fARBPtr = OpenGLExtProcAddress("glProgramLocalParameter4fARB")
    glProgramLocalParameter4dvARBPtr = OpenGLExtProcAddress("glProgramLocalParameter4dvARB")
    glProgramLocalParameter4dARBPtr = OpenGLExtProcAddress("glProgramLocalParameter4dARB")
    glProgramEnvParameter4fvARBPtr = OpenGLExtProcAddress("glProgramEnvParameter4fvARB")
    glProgramEnvParameter4fARBPtr = OpenGLExtProcAddress("glProgramEnvParameter4fARB")
    glProgramEnvParameter4dvARBPtr = OpenGLExtProcAddress("glProgramEnvParameter4dvARB")
    glProgramEnvParameter4dARBPtr = OpenGLExtProcAddress("glProgramEnvParameter4dARB")
    glIsProgramARBPtr = OpenGLExtProcAddress("glIsProgramARB")
    glGetVertexAttribivARBPtr = OpenGLExtProcAddress("glGetVertexAttribivARB")
    glGetVertexAttribfvARBPtr = OpenGLExtProcAddress("glGetVertexAttribfvARB")
    glGetVertexAttribdvARBPtr = OpenGLExtProcAddress("glGetVertexAttribdvARB")
    glGetVertexAttribPointervARBPtr = OpenGLExtProcAddress("glGetVertexAttribPointervARB")
    glGetProgramivARBPtr = OpenGLExtProcAddress("glGetProgramivARB")
    glGetProgramStringARBPtr = OpenGLExtProcAddress("glGetProgramStringARB")
    glGetProgramLocalParameterfvARBPtr = OpenGLExtProcAddress("glGetProgramLocalParameterfvARB")
    glGetProgramLocalParameterdvARBPtr = OpenGLExtProcAddress("glGetProgramLocalParameterdvARB")
    glGetProgramEnvParameterfvARBPtr = OpenGLExtProcAddress("glGetProgramEnvParameterfvARB")
    glGetProgramEnvParameterdvARBPtr = OpenGLExtProcAddress("glGetProgramEnvParameterdvARB")
    glGenProgramsARBPtr = OpenGLExtProcAddress("glGenProgramsARB")
    glEnableVertexAttribArrayARBPtr = OpenGLExtProcAddress("glEnableVertexAttribArrayARB")
    glDisableVertexAttribArrayARBPtr = OpenGLExtProcAddress("glDisableVertexAttribArrayARB")
    glDeleteProgramsARBPtr = OpenGLExtProcAddress("glDeleteProgramsARB")
    glBindProgramARBPtr = OpenGLExtProcAddress("glBindProgramARB")
    glUnmapBufferARBPtr = OpenGLExtProcAddress("glUnmapBufferARB")
    glIsBufferARBPtr = OpenGLExtProcAddress("glIsBufferARB")
    glGetBufferSubDataARBPtr = OpenGLExtProcAddress("glGetBufferSubDataARB")
    glGetBufferPointervARBPtr = OpenGLExtProcAddress("glGetBufferPointervARB")
    glGetBufferParameterivARBPtr = OpenGLExtProcAddress("glGetBufferParameterivARB")
    glGenBuffersARBPtr = OpenGLExtProcAddress("glGenBuffersARB")
    glDeleteBuffersARBPtr = OpenGLExtProcAddress("glDeleteBuffersARB")
    glBufferSubDataARBPtr = OpenGLExtProcAddress("glBufferSubDataARB")
    glBufferDataARBPtr = OpenGLExtProcAddress("glBufferDataARB")
    glBindBufferARBPtr = OpenGLExtProcAddress("glBindBufferARB")
    glWeightusvARBPtr = OpenGLExtProcAddress("glWeightusvARB")
    glWeightuivARBPtr = OpenGLExtProcAddress("glWeightuivARB")
    glWeightubvARBPtr = OpenGLExtProcAddress("glWeightubvARB")
    glWeightsvARBPtr = OpenGLExtProcAddress("glWeightsvARB")
    glWeightivARBPtr = OpenGLExtProcAddress("glWeightivARB")
    glWeightfvARBPtr = OpenGLExtProcAddress("glWeightfvARB")
    glWeightdvARBPtr = OpenGLExtProcAddress("glWeightdvARB")
    glWeightbvARBPtr = OpenGLExtProcAddress("glWeightbvARB")
    glWeightPointerARBPtr = OpenGLExtProcAddress("glWeightPointerARB")
    glVertexBlendARBPtr = OpenGLExtProcAddress("glVertexBlendARB")
    glVertexBindingDivisorPtr = OpenGLExtProcAddress("glVertexBindingDivisor")
    glVertexAttribLFormatPtr = OpenGLExtProcAddress("glVertexAttribLFormat")
    glVertexAttribIFormatPtr = OpenGLExtProcAddress("glVertexAttribIFormat")
    glVertexAttribFormatPtr = OpenGLExtProcAddress("glVertexAttribFormat")
    glVertexAttribBindingPtr = OpenGLExtProcAddress("glVertexAttribBinding")
    glVertexArrayVertexBindingDivisorEXTPtr = OpenGLExtProcAddress("glVertexArrayVertexBindingDivisorEXT")
    glVertexArrayVertexAttribLFormatEXTPtr = OpenGLExtProcAddress("glVertexArrayVertexAttribLFormatEXT")
    glVertexArrayVertexAttribIFormatEXTPtr = OpenGLExtProcAddress("glVertexArrayVertexAttribIFormatEXT")
    glVertexArrayVertexAttribFormatEXTPtr = OpenGLExtProcAddress("glVertexArrayVertexAttribFormatEXT")
    glVertexArrayVertexAttribBindingEXTPtr = OpenGLExtProcAddress("glVertexArrayVertexAttribBindingEXT")
    glVertexArrayBindVertexBufferEXTPtr = OpenGLExtProcAddress("glVertexArrayBindVertexBufferEXT")
    glBindVertexBufferPtr = OpenGLExtProcAddress("glBindVertexBuffer")
    glVertexAttribLPointerPtr = OpenGLExtProcAddress("glVertexAttribLPointer")
    glVertexAttribL4dvPtr = OpenGLExtProcAddress("glVertexAttribL4dv")
    glVertexAttribL4dPtr = OpenGLExtProcAddress("glVertexAttribL4d")
    glVertexAttribL3dvPtr = OpenGLExtProcAddress("glVertexAttribL3dv")
    glVertexAttribL3dPtr = OpenGLExtProcAddress("glVertexAttribL3d")
    glVertexAttribL2dvPtr = OpenGLExtProcAddress("glVertexAttribL2dv")
    glVertexAttribL2dPtr = OpenGLExtProcAddress("glVertexAttribL2d")
    glVertexAttribL1dvPtr = OpenGLExtProcAddress("glVertexAttribL1dv")
    glVertexAttribL1dPtr = OpenGLExtProcAddress("glVertexAttribL1d")
    glGetVertexAttribLdvPtr = OpenGLExtProcAddress("glGetVertexAttribLdv")
    glIsVertexArrayARBPtr = OpenGLExtProcAddress("glIsVertexArrayARB")
    glGenVertexArraysARBPtr = OpenGLExtProcAddress("glGenVertexArraysARB")
    glDeleteVertexArraysARBPtr = OpenGLExtProcAddress("glDeleteVertexArraysARB")
    glBindVertexArrayARBPtr = OpenGLExtProcAddress("glBindVertexArrayARB")
    glUniformBlockBindingPtr = OpenGLExtProcAddress("glUniformBlockBinding")
    glGetUniformIndicesPtr = OpenGLExtProcAddress("glGetUniformIndices")
    glGetUniformBlockIndexPtr = OpenGLExtProcAddress("glGetUniformBlockIndex")
    glGetIntegeri_vPtr = OpenGLExtProcAddress("glGetIntegeri_v")
    glGetActiveUniformsivPtr = OpenGLExtProcAddress("glGetActiveUniformsiv")
    glGetActiveUniformNamePtr = OpenGLExtProcAddress("glGetActiveUniformName")
    glGetActiveUniformBlockivPtr = OpenGLExtProcAddress("glGetActiveUniformBlockiv")
    glGetActiveUniformBlockNamePtr = OpenGLExtProcAddress("glGetActiveUniformBlockName")
    glBindBufferRangePtr = OpenGLExtProcAddress("glBindBufferRange")
    glBindBufferBasePtr = OpenGLExtProcAddress("glBindBufferBase")
    glMultTransposeMatrixfARBPtr = OpenGLExtProcAddress("glMultTransposeMatrixfARB")
    glMultTransposeMatrixdARBPtr = OpenGLExtProcAddress("glMultTransposeMatrixdARB")
    glLoadTransposeMatrixfARBPtr = OpenGLExtProcAddress("glLoadTransposeMatrixfARB")
    glLoadTransposeMatrixdARBPtr = OpenGLExtProcAddress("glLoadTransposeMatrixdARB")
    glDrawTransformFeedbackStreamInstancedPtr = OpenGLExtProcAddress("glDrawTransformFeedbackStreamInstanced")
    glDrawTransformFeedbackInstancedPtr = OpenGLExtProcAddress("glDrawTransformFeedbackInstanced")
    glGetQueryIndexedivPtr = OpenGLExtProcAddress("glGetQueryIndexediv")
    glEndQueryIndexedPtr = OpenGLExtProcAddress("glEndQueryIndexed")
    glDrawTransformFeedbackStreamPtr = OpenGLExtProcAddress("glDrawTransformFeedbackStream")
    glBeginQueryIndexedPtr = OpenGLExtProcAddress("glBeginQueryIndexed")
    glResumeTransformFeedbackPtr = OpenGLExtProcAddress("glResumeTransformFeedback")
    glPauseTransformFeedbackPtr = OpenGLExtProcAddress("glPauseTransformFeedback")
    glIsTransformFeedbackPtr = OpenGLExtProcAddress("glIsTransformFeedback")
    glGenTransformFeedbacksPtr = OpenGLExtProcAddress("glGenTransformFeedbacks")
    glDrawTransformFeedbackPtr = OpenGLExtProcAddress("glDrawTransformFeedback")
    glDeleteTransformFeedbacksPtr = OpenGLExtProcAddress("glDeleteTransformFeedbacks")
    glBindTransformFeedbackPtr = OpenGLExtProcAddress("glBindTransformFeedback")
    glQueryCounterPtr = OpenGLExtProcAddress("glQueryCounter")
    glGetQueryObjectui64vPtr = OpenGLExtProcAddress("glGetQueryObjectui64v")
    glGetQueryObjecti64vPtr = OpenGLExtProcAddress("glGetQueryObjecti64v")
    glTextureViewPtr = OpenGLExtProcAddress("glTextureView")
    glTextureStorage3DMultisampleEXTPtr = OpenGLExtProcAddress("glTextureStorage3DMultisampleEXT")
    glTextureStorage2DMultisampleEXTPtr = OpenGLExtProcAddress("glTextureStorage2DMultisampleEXT")
    glTexStorage3DMultisamplePtr = OpenGLExtProcAddress("glTexStorage3DMultisample")
    glTexStorage2DMultisamplePtr = OpenGLExtProcAddress("glTexStorage2DMultisample")
    glTexStorage3DPtr = OpenGLExtProcAddress("glTexStorage3D")
    glTexStorage2DPtr = OpenGLExtProcAddress("glTexStorage2D")
    glTexStorage1DPtr = OpenGLExtProcAddress("glTexStorage1D")
    glTexImage3DMultisamplePtr = OpenGLExtProcAddress("glTexImage3DMultisample")
    glTexImage2DMultisamplePtr = OpenGLExtProcAddress("glTexImage2DMultisample")
    glSampleMaskiPtr = OpenGLExtProcAddress("glSampleMaski")
    glGetMultisamplefvPtr = OpenGLExtProcAddress("glGetMultisamplefv")
    glGetCompressedTexImageARBPtr = OpenGLExtProcAddress("glGetCompressedTexImageARB")
    glCompressedTexSubImage3DARBPtr = OpenGLExtProcAddress("glCompressedTexSubImage3DARB")
    glCompressedTexSubImage2DARBPtr = OpenGLExtProcAddress("glCompressedTexSubImage2DARB")
    glCompressedTexSubImage1DARBPtr = OpenGLExtProcAddress("glCompressedTexSubImage1DARB")
    glCompressedTexImage3DARBPtr = OpenGLExtProcAddress("glCompressedTexImage3DARB")
    glCompressedTexImage2DARBPtr = OpenGLExtProcAddress("glCompressedTexImage2DARB")
    glCompressedTexImage1DARBPtr = OpenGLExtProcAddress("glCompressedTexImage1DARB")
    glTextureBufferRangeEXTPtr = OpenGLExtProcAddress("glTextureBufferRangeEXT")
    glTexBufferRangePtr = OpenGLExtProcAddress("glTexBufferRange")
    glTexBufferARBPtr = OpenGLExtProcAddress("glTexBufferARB")
    glTextureBarrierPtr = OpenGLExtProcAddress("glTextureBarrier")
    glPatchParameteriPtr = OpenGLExtProcAddress("glPatchParameteri")
    glPatchParameterfvPtr = OpenGLExtProcAddress("glPatchParameterfv")
    glWaitSyncPtr = OpenGLExtProcAddress("glWaitSync")
    glIsSyncPtr = OpenGLExtProcAddress("glIsSync")
    glGetSyncivPtr = OpenGLExtProcAddress("glGetSynciv")
    glGetInteger64vPtr = OpenGLExtProcAddress("glGetInteger64v")
    glFenceSyncPtr = OpenGLExtProcAddress("glFenceSync")
    glDeleteSyncPtr = OpenGLExtProcAddress("glDeleteSync")
    glClientWaitSyncPtr = OpenGLExtProcAddress("glClientWaitSync")
    glTexPageCommitmentARBPtr = OpenGLExtProcAddress("glTexPageCommitmentARB")
    glBufferPageCommitmentARBPtr = OpenGLExtProcAddress("glBufferPageCommitmentARB")
    glNamedStringARBPtr = OpenGLExtProcAddress("glNamedStringARB")
    glIsNamedStringARBPtr = OpenGLExtProcAddress("glIsNamedStringARB")
    glGetNamedStringivARBPtr = OpenGLExtProcAddress("glGetNamedStringivARB")
    glGetNamedStringARBPtr = OpenGLExtProcAddress("glGetNamedStringARB")
    glDeleteNamedStringARBPtr = OpenGLExtProcAddress("glDeleteNamedStringARB")
    glCompileShaderIncludeARBPtr = OpenGLExtProcAddress("glCompileShaderIncludeARB")
    glUniformSubroutinesuivPtr = OpenGLExtProcAddress("glUniformSubroutinesuiv")
    glGetUniformSubroutineuivPtr = OpenGLExtProcAddress("glGetUniformSubroutineuiv")
    glGetSubroutineUniformLocationPtr = OpenGLExtProcAddress("glGetSubroutineUniformLocation")
    glGetSubroutineIndexPtr = OpenGLExtProcAddress("glGetSubroutineIndex")
    glGetProgramStageivPtr = OpenGLExtProcAddress("glGetProgramStageiv")
    glGetActiveSubroutineUniformivPtr = OpenGLExtProcAddress("glGetActiveSubroutineUniformiv")
    glGetActiveSubroutineUniformNamePtr = OpenGLExtProcAddress("glGetActiveSubroutineUniformName")
    glGetActiveSubroutineNamePtr = OpenGLExtProcAddress("glGetActiveSubroutineName")
    glShaderStorageBlockBindingPtr = OpenGLExtProcAddress("glShaderStorageBlockBinding")
    glValidateProgramARBPtr = OpenGLExtProcAddress("glValidateProgramARB")
    glUseProgramObjectARBPtr = OpenGLExtProcAddress("glUseProgramObjectARB")
    glUniformMatrix4fvARBPtr = OpenGLExtProcAddress("glUniformMatrix4fvARB")
    glUniformMatrix3fvARBPtr = OpenGLExtProcAddress("glUniformMatrix3fvARB")
    glUniformMatrix2fvARBPtr = OpenGLExtProcAddress("glUniformMatrix2fvARB")
    glUniform4ivARBPtr = OpenGLExtProcAddress("glUniform4ivARB")
    glUniform4iARBPtr = OpenGLExtProcAddress("glUniform4iARB")
    glUniform4fvARBPtr = OpenGLExtProcAddress("glUniform4fvARB")
    glUniform4fARBPtr = OpenGLExtProcAddress("glUniform4fARB")
    glUniform3ivARBPtr = OpenGLExtProcAddress("glUniform3ivARB")
    glUniform3iARBPtr = OpenGLExtProcAddress("glUniform3iARB")
    glUniform3fvARBPtr = OpenGLExtProcAddress("glUniform3fvARB")
    glUniform3fARBPtr = OpenGLExtProcAddress("glUniform3fARB")
    glUniform2ivARBPtr = OpenGLExtProcAddress("glUniform2ivARB")
    glUniform2iARBPtr = OpenGLExtProcAddress("glUniform2iARB")
    glUniform2fvARBPtr = OpenGLExtProcAddress("glUniform2fvARB")
    glUniform2fARBPtr = OpenGLExtProcAddress("glUniform2fARB")
    glUniform1ivARBPtr = OpenGLExtProcAddress("glUniform1ivARB")
    glUniform1iARBPtr = OpenGLExtProcAddress("glUniform1iARB")
    glUniform1fvARBPtr = OpenGLExtProcAddress("glUniform1fvARB")
    glUniform1fARBPtr = OpenGLExtProcAddress("glUniform1fARB")
    glShaderSourceARBPtr = OpenGLExtProcAddress("glShaderSourceARB")
    glLinkProgramARBPtr = OpenGLExtProcAddress("glLinkProgramARB")
    glGetUniformivARBPtr = OpenGLExtProcAddress("glGetUniformivARB")
    glGetUniformfvARBPtr = OpenGLExtProcAddress("glGetUniformfvARB")
    glGetUniformLocationARBPtr = OpenGLExtProcAddress("glGetUniformLocationARB")
    glGetShaderSourceARBPtr = OpenGLExtProcAddress("glGetShaderSourceARB")
    glGetObjectParameterivARBPtr = OpenGLExtProcAddress("glGetObjectParameterivARB")
    glGetObjectParameterfvARBPtr = OpenGLExtProcAddress("glGetObjectParameterfvARB")
    glGetInfoLogARBPtr = OpenGLExtProcAddress("glGetInfoLogARB")
    glGetHandleARBPtr = OpenGLExtProcAddress("glGetHandleARB")
    glGetAttachedObjectsARBPtr = OpenGLExtProcAddress("glGetAttachedObjectsARB")
    glGetActiveUniformARBPtr = OpenGLExtProcAddress("glGetActiveUniformARB")
    glDetachObjectARBPtr = OpenGLExtProcAddress("glDetachObjectARB")
    glDeleteObjectARBPtr = OpenGLExtProcAddress("glDeleteObjectARB")
    glCreateShaderObjectARBPtr = OpenGLExtProcAddress("glCreateShaderObjectARB")
    glCreateProgramObjectARBPtr = OpenGLExtProcAddress("glCreateProgramObjectARB")
    glCompileShaderARBPtr = OpenGLExtProcAddress("glCompileShaderARB")
    glAttachObjectARBPtr = OpenGLExtProcAddress("glAttachObjectARB")
    glMemoryBarrierPtr = OpenGLExtProcAddress("glMemoryBarrier")
    glBindImageTexturePtr = OpenGLExtProcAddress("glBindImageTexture")
    glGetActiveAtomicCounterBufferivPtr = OpenGLExtProcAddress("glGetActiveAtomicCounterBufferiv")
    glValidateProgramPipelinePtr = OpenGLExtProcAddress("glValidateProgramPipeline")
    glUseProgramStagesPtr = OpenGLExtProcAddress("glUseProgramStages")
    glProgramUniformMatrix4x3fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix4x3fv")
    glProgramUniformMatrix4x3dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix4x3dv")
    glProgramUniformMatrix4x2fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix4x2fv")
    glProgramUniformMatrix4x2dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix4x2dv")
    glProgramUniformMatrix4fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix4fv")
    glProgramUniformMatrix4dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix4dv")
    glProgramUniformMatrix3x4fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix3x4fv")
    glProgramUniformMatrix3x4dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix3x4dv")
    glProgramUniformMatrix3x2fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix3x2fv")
    glProgramUniformMatrix3x2dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix3x2dv")
    glProgramUniformMatrix3fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix3fv")
    glProgramUniformMatrix3dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix3dv")
    glProgramUniformMatrix2x4fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix2x4fv")
    glProgramUniformMatrix2x4dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix2x4dv")
    glProgramUniformMatrix2x3fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix2x3fv")
    glProgramUniformMatrix2x3dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix2x3dv")
    glProgramUniformMatrix2fvPtr = OpenGLExtProcAddress("glProgramUniformMatrix2fv")
    glProgramUniformMatrix2dvPtr = OpenGLExtProcAddress("glProgramUniformMatrix2dv")
    glProgramUniform4uivPtr = OpenGLExtProcAddress("glProgramUniform4uiv")
    glProgramUniform4uiPtr = OpenGLExtProcAddress("glProgramUniform4ui")
    glProgramUniform4ivPtr = OpenGLExtProcAddress("glProgramUniform4iv")
    glProgramUniform4iPtr = OpenGLExtProcAddress("glProgramUniform4i")
    glProgramUniform4fvPtr = OpenGLExtProcAddress("glProgramUniform4fv")
    glProgramUniform4fPtr = OpenGLExtProcAddress("glProgramUniform4f")
    glProgramUniform4dvPtr = OpenGLExtProcAddress("glProgramUniform4dv")
    glProgramUniform4dPtr = OpenGLExtProcAddress("glProgramUniform4d")
    glProgramUniform3uivPtr = OpenGLExtProcAddress("glProgramUniform3uiv")
    glProgramUniform3uiPtr = OpenGLExtProcAddress("glProgramUniform3ui")
    glProgramUniform3ivPtr = OpenGLExtProcAddress("glProgramUniform3iv")
    glProgramUniform3iPtr = OpenGLExtProcAddress("glProgramUniform3i")
    glProgramUniform3fvPtr = OpenGLExtProcAddress("glProgramUniform3fv")
    glProgramUniform3fPtr = OpenGLExtProcAddress("glProgramUniform3f")
    glProgramUniform3dvPtr = OpenGLExtProcAddress("glProgramUniform3dv")
    glProgramUniform3dPtr = OpenGLExtProcAddress("glProgramUniform3d")
    glProgramUniform2uivPtr = OpenGLExtProcAddress("glProgramUniform2uiv")
    glProgramUniform2uiPtr = OpenGLExtProcAddress("glProgramUniform2ui")
    glProgramUniform2ivPtr = OpenGLExtProcAddress("glProgramUniform2iv")
    glProgramUniform2iPtr = OpenGLExtProcAddress("glProgramUniform2i")
    glProgramUniform2fvPtr = OpenGLExtProcAddress("glProgramUniform2fv")
    glProgramUniform2fPtr = OpenGLExtProcAddress("glProgramUniform2f")
    glProgramUniform2dvPtr = OpenGLExtProcAddress("glProgramUniform2dv")
    glProgramUniform2dPtr = OpenGLExtProcAddress("glProgramUniform2d")
    glProgramUniform1uivPtr = OpenGLExtProcAddress("glProgramUniform1uiv")
    glProgramUniform1uiPtr = OpenGLExtProcAddress("glProgramUniform1ui")
    glProgramUniform1ivPtr = OpenGLExtProcAddress("glProgramUniform1iv")
    glProgramUniform1iPtr = OpenGLExtProcAddress("glProgramUniform1i")
    glProgramUniform1fvPtr = OpenGLExtProcAddress("glProgramUniform1fv")
    glProgramUniform1fPtr = OpenGLExtProcAddress("glProgramUniform1f")
    glProgramUniform1dvPtr = OpenGLExtProcAddress("glProgramUniform1dv")
    glProgramUniform1dPtr = OpenGLExtProcAddress("glProgramUniform1d")
    glIsProgramPipelinePtr = OpenGLExtProcAddress("glIsProgramPipeline")
    glGetProgramPipelineivPtr = OpenGLExtProcAddress("glGetProgramPipelineiv")
    glGetProgramPipelineInfoLogPtr = OpenGLExtProcAddress("glGetProgramPipelineInfoLog")
    glGenProgramPipelinesPtr = OpenGLExtProcAddress("glGenProgramPipelines")
    glDeleteProgramPipelinesPtr = OpenGLExtProcAddress("glDeleteProgramPipelines")
    glCreateShaderProgramvPtr = OpenGLExtProcAddress("glCreateShaderProgramv")
    glBindProgramPipelinePtr = OpenGLExtProcAddress("glBindProgramPipeline")
    glActiveShaderProgramPtr = OpenGLExtProcAddress("glActiveShaderProgram")
    glSamplerParameterivPtr = OpenGLExtProcAddress("glSamplerParameteriv")
    glSamplerParameteriPtr = OpenGLExtProcAddress("glSamplerParameteri")
    glSamplerParameterfvPtr = OpenGLExtProcAddress("glSamplerParameterfv")
    glSamplerParameterfPtr = OpenGLExtProcAddress("glSamplerParameterf")
    glSamplerParameterIuivPtr = OpenGLExtProcAddress("glSamplerParameterIuiv")
    glSamplerParameterIivPtr = OpenGLExtProcAddress("glSamplerParameterIiv")
    glIsSamplerPtr = OpenGLExtProcAddress("glIsSampler")
    glGetSamplerParameterivPtr = OpenGLExtProcAddress("glGetSamplerParameteriv")
    glGetSamplerParameterfvPtr = OpenGLExtProcAddress("glGetSamplerParameterfv")
    glGetSamplerParameterIuivPtr = OpenGLExtProcAddress("glGetSamplerParameterIuiv")
    glGetSamplerParameterIivPtr = OpenGLExtProcAddress("glGetSamplerParameterIiv")
    glGenSamplersPtr = OpenGLExtProcAddress("glGenSamplers")
    glDeleteSamplersPtr = OpenGLExtProcAddress("glDeleteSamplers")
    glBindSamplerPtr = OpenGLExtProcAddress("glBindSampler")
    glMinSampleShadingARBPtr = OpenGLExtProcAddress("glMinSampleShadingARB")
    glNamedFramebufferSampleLocationsfvARBPtr = OpenGLExtProcAddress("glNamedFramebufferSampleLocationsfvARB")
    glFramebufferSampleLocationsfvARBPtr = OpenGLExtProcAddress("glFramebufferSampleLocationsfvARB")
    glReadnPixelsARBPtr = OpenGLExtProcAddress("glReadnPixelsARB")
    glGetnUniformuivARBPtr = OpenGLExtProcAddress("glGetnUniformuivARB")
    glGetnUniformivARBPtr = OpenGLExtProcAddress("glGetnUniformivARB")
    glGetnUniformfvARBPtr = OpenGLExtProcAddress("glGetnUniformfvARB")
    glGetnUniformdvARBPtr = OpenGLExtProcAddress("glGetnUniformdvARB")
    glGetnTexImageARBPtr = OpenGLExtProcAddress("glGetnTexImageARB")
    glGetnSeparableFilterARBPtr = OpenGLExtProcAddress("glGetnSeparableFilterARB")
    glGetnPolygonStippleARBPtr = OpenGLExtProcAddress("glGetnPolygonStippleARB")
    glGetnPixelMapusvARBPtr = OpenGLExtProcAddress("glGetnPixelMapusvARB")
    glGetnPixelMapuivARBPtr = OpenGLExtProcAddress("glGetnPixelMapuivARB")
    glGetnPixelMapfvARBPtr = OpenGLExtProcAddress("glGetnPixelMapfvARB")
    glGetnMinmaxARBPtr = OpenGLExtProcAddress("glGetnMinmaxARB")
    glGetnMapivARBPtr = OpenGLExtProcAddress("glGetnMapivARB")
    glGetnMapfvARBPtr = OpenGLExtProcAddress("glGetnMapfvARB")
    glGetnMapdvARBPtr = OpenGLExtProcAddress("glGetnMapdvARB")
    glGetnHistogramARBPtr = OpenGLExtProcAddress("glGetnHistogramARB")
    glGetnConvolutionFilterARBPtr = OpenGLExtProcAddress("glGetnConvolutionFilterARB")
    glGetnCompressedTexImageARBPtr = OpenGLExtProcAddress("glGetnCompressedTexImageARB")
    glGetnColorTableARBPtr = OpenGLExtProcAddress("glGetnColorTableARB")
    glGetGraphicsResetStatusARBPtr = OpenGLExtProcAddress("glGetGraphicsResetStatusARB")
    glProvokingVertexPtr = OpenGLExtProcAddress("glProvokingVertex")
    glGetProgramResourceivPtr = OpenGLExtProcAddress("glGetProgramResourceiv")
    glGetProgramResourceNamePtr = OpenGLExtProcAddress("glGetProgramResourceName")
    glGetProgramResourceLocationIndexPtr = OpenGLExtProcAddress("glGetProgramResourceLocationIndex")
    glGetProgramResourceLocationPtr = OpenGLExtProcAddress("glGetProgramResourceLocation")
    glGetProgramResourceIndexPtr = OpenGLExtProcAddress("glGetProgramResourceIndex")
    glGetProgramInterfaceivPtr = OpenGLExtProcAddress("glGetProgramInterfaceiv")
    glPolygonOffsetClampPtr = OpenGLExtProcAddress("glPolygonOffsetClamp")
    glPointParameterfvARBPtr = OpenGLExtProcAddress("glPointParameterfvARB")
    glPointParameterfARBPtr = OpenGLExtProcAddress("glPointParameterfARB")
    glMaxShaderCompilerThreadsARBPtr = OpenGLExtProcAddress("glMaxShaderCompilerThreadsARB")
    glIsQueryARBPtr = OpenGLExtProcAddress("glIsQueryARB")
    glGetQueryivARBPtr = OpenGLExtProcAddress("glGetQueryivARB")
    glGetQueryObjectuivARBPtr = OpenGLExtProcAddress("glGetQueryObjectuivARB")
    glGetQueryObjectivARBPtr = OpenGLExtProcAddress("glGetQueryObjectivARB")
    glGenQueriesARBPtr = OpenGLExtProcAddress("glGenQueriesARB")
    glEndQueryARBPtr = OpenGLExtProcAddress("glEndQueryARB")
    glDeleteQueriesARBPtr = OpenGLExtProcAddress("glDeleteQueriesARB")
    glBeginQueryARBPtr = OpenGLExtProcAddress("glBeginQueryARB")
    glMultiTexCoord4svARBPtr = OpenGLExtProcAddress("glMultiTexCoord4svARB")
    glMultiTexCoord4sARBPtr = OpenGLExtProcAddress("glMultiTexCoord4sARB")
    glMultiTexCoord4ivARBPtr = OpenGLExtProcAddress("glMultiTexCoord4ivARB")
    glMultiTexCoord4iARBPtr = OpenGLExtProcAddress("glMultiTexCoord4iARB")
    glMultiTexCoord4fvARBPtr = OpenGLExtProcAddress("glMultiTexCoord4fvARB")
    glMultiTexCoord4fARBPtr = OpenGLExtProcAddress("glMultiTexCoord4fARB")
    glMultiTexCoord4dvARBPtr = OpenGLExtProcAddress("glMultiTexCoord4dvARB")
    glMultiTexCoord4dARBPtr = OpenGLExtProcAddress("glMultiTexCoord4dARB")
    glMultiTexCoord3svARBPtr = OpenGLExtProcAddress("glMultiTexCoord3svARB")
    glMultiTexCoord3sARBPtr = OpenGLExtProcAddress("glMultiTexCoord3sARB")
    glMultiTexCoord3ivARBPtr = OpenGLExtProcAddress("glMultiTexCoord3ivARB")
    glMultiTexCoord3iARBPtr = OpenGLExtProcAddress("glMultiTexCoord3iARB")
    glMultiTexCoord3fvARBPtr = OpenGLExtProcAddress("glMultiTexCoord3fvARB")
    glMultiTexCoord3fARBPtr = OpenGLExtProcAddress("glMultiTexCoord3fARB")
    glMultiTexCoord3dvARBPtr = OpenGLExtProcAddress("glMultiTexCoord3dvARB")
    glMultiTexCoord3dARBPtr = OpenGLExtProcAddress("glMultiTexCoord3dARB")
    glMultiTexCoord2svARBPtr = OpenGLExtProcAddress("glMultiTexCoord2svARB")
    glMultiTexCoord2sARBPtr = OpenGLExtProcAddress("glMultiTexCoord2sARB")
    glMultiTexCoord2ivARBPtr = OpenGLExtProcAddress("glMultiTexCoord2ivARB")
    glMultiTexCoord2iARBPtr = OpenGLExtProcAddress("glMultiTexCoord2iARB")
    glMultiTexCoord2fvARBPtr = OpenGLExtProcAddress("glMultiTexCoord2fvARB")
    glMultiTexCoord2fARBPtr = OpenGLExtProcAddress("glMultiTexCoord2fARB")
    glMultiTexCoord2dvARBPtr = OpenGLExtProcAddress("glMultiTexCoord2dvARB")
    glMultiTexCoord2dARBPtr = OpenGLExtProcAddress("glMultiTexCoord2dARB")
    glMultiTexCoord1svARBPtr = OpenGLExtProcAddress("glMultiTexCoord1svARB")
    glMultiTexCoord1sARBPtr = OpenGLExtProcAddress("glMultiTexCoord1sARB")
    glMultiTexCoord1ivARBPtr = OpenGLExtProcAddress("glMultiTexCoord1ivARB")
    glMultiTexCoord1iARBPtr = OpenGLExtProcAddress("glMultiTexCoord1iARB")
    glMultiTexCoord1fvARBPtr = OpenGLExtProcAddress("glMultiTexCoord1fvARB")
    glMultiTexCoord1fARBPtr = OpenGLExtProcAddress("glMultiTexCoord1fARB")
    glMultiTexCoord1dvARBPtr = OpenGLExtProcAddress("glMultiTexCoord1dvARB")
    glMultiTexCoord1dARBPtr = OpenGLExtProcAddress("glMultiTexCoord1dARB")
    glClientActiveTextureARBPtr = OpenGLExtProcAddress("glClientActiveTextureARB")
    glActiveTextureARBPtr = OpenGLExtProcAddress("glActiveTextureARB")
    glSampleCoverageARBPtr = OpenGLExtProcAddress("glSampleCoverageARB")
    glMultiDrawElementsIndirectPtr = OpenGLExtProcAddress("glMultiDrawElementsIndirect")
    glMultiDrawArraysIndirectPtr = OpenGLExtProcAddress("glMultiDrawArraysIndirect")
    glBindVertexBuffersPtr = OpenGLExtProcAddress("glBindVertexBuffers")
    glBindTexturesPtr = OpenGLExtProcAddress("glBindTextures")
    glBindSamplersPtr = OpenGLExtProcAddress("glBindSamplers")
    glBindImageTexturesPtr = OpenGLExtProcAddress("glBindImageTextures")
    glBindBuffersRangePtr = OpenGLExtProcAddress("glBindBuffersRange")
    glBindBuffersBasePtr = OpenGLExtProcAddress("glBindBuffersBase")
    glMatrixIndexusvARBPtr = OpenGLExtProcAddress("glMatrixIndexusvARB")
    glMatrixIndexuivARBPtr = OpenGLExtProcAddress("glMatrixIndexuivARB")
    glMatrixIndexubvARBPtr = OpenGLExtProcAddress("glMatrixIndexubvARB")
    glMatrixIndexPointerARBPtr = OpenGLExtProcAddress("glMatrixIndexPointerARB")
    glCurrentPaletteMatrixARBPtr = OpenGLExtProcAddress("glCurrentPaletteMatrixARB")
    glFlushMappedBufferRangePtr = OpenGLExtProcAddress("glFlushMappedBufferRange")
    glInvalidateTexSubImagePtr = OpenGLExtProcAddress("glInvalidateTexSubImage")
    glInvalidateTexImagePtr = OpenGLExtProcAddress("glInvalidateTexImage")
    glInvalidateSubFramebufferPtr = OpenGLExtProcAddress("glInvalidateSubFramebuffer")
    glInvalidateFramebufferPtr = OpenGLExtProcAddress("glInvalidateFramebuffer")
    glInvalidateBufferSubDataPtr = OpenGLExtProcAddress("glInvalidateBufferSubData")
    glInvalidateBufferDataPtr = OpenGLExtProcAddress("glInvalidateBufferData")
    glGetInternalformati64vPtr = OpenGLExtProcAddress("glGetInternalformati64v")
    glGetInternalformativPtr = OpenGLExtProcAddress("glGetInternalformativ")
    glVertexAttribDivisorARBPtr = OpenGLExtProcAddress("glVertexAttribDivisorARB")
    glDrawElementsInstancedARBPtr = OpenGLExtProcAddress("glDrawElementsInstancedARB")
    glDrawArraysInstancedARBPtr = OpenGLExtProcAddress("glDrawArraysInstancedARB")
    glMultiDrawElementsIndirectCountARBPtr = OpenGLExtProcAddress("glMultiDrawElementsIndirectCountARB")
    glMultiDrawArraysIndirectCountARBPtr = OpenGLExtProcAddress("glMultiDrawArraysIndirectCountARB")
    glSeparableFilter2DPtr = OpenGLExtProcAddress("glSeparableFilter2D")
    glResetMinmaxPtr = OpenGLExtProcAddress("glResetMinmax")
    glResetHistogramPtr = OpenGLExtProcAddress("glResetHistogram")
    glMinmaxPtr = OpenGLExtProcAddress("glMinmax")
    glHistogramPtr = OpenGLExtProcAddress("glHistogram")
    glGetSeparableFilterPtr = OpenGLExtProcAddress("glGetSeparableFilter")
    glGetMinmaxParameterivPtr = OpenGLExtProcAddress("glGetMinmaxParameteriv")
    glGetMinmaxParameterfvPtr = OpenGLExtProcAddress("glGetMinmaxParameterfv")
    glGetMinmaxPtr = OpenGLExtProcAddress("glGetMinmax")
    glGetHistogramParameterivPtr = OpenGLExtProcAddress("glGetHistogramParameteriv")
    glGetHistogramParameterfvPtr = OpenGLExtProcAddress("glGetHistogramParameterfv")
    glGetHistogramPtr = OpenGLExtProcAddress("glGetHistogram")
    glGetConvolutionParameterivPtr = OpenGLExtProcAddress("glGetConvolutionParameteriv")
    glGetConvolutionParameterfvPtr = OpenGLExtProcAddress("glGetConvolutionParameterfv")
    glGetConvolutionFilterPtr = OpenGLExtProcAddress("glGetConvolutionFilter")
    glGetColorTableParameterivPtr = OpenGLExtProcAddress("glGetColorTableParameteriv")
    glGetColorTableParameterfvPtr = OpenGLExtProcAddress("glGetColorTableParameterfv")
    glGetColorTablePtr = OpenGLExtProcAddress("glGetColorTable")
    glCopyConvolutionFilter2DPtr = OpenGLExtProcAddress("glCopyConvolutionFilter2D")
    glCopyConvolutionFilter1DPtr = OpenGLExtProcAddress("glCopyConvolutionFilter1D")
    glCopyColorTablePtr = OpenGLExtProcAddress("glCopyColorTable")
    glCopyColorSubTablePtr = OpenGLExtProcAddress("glCopyColorSubTable")
    glConvolutionParameterivPtr = OpenGLExtProcAddress("glConvolutionParameteriv")
    glConvolutionParameteriPtr = OpenGLExtProcAddress("glConvolutionParameteri")
    glConvolutionParameterfvPtr = OpenGLExtProcAddress("glConvolutionParameterfv")
    glConvolutionParameterfPtr = OpenGLExtProcAddress("glConvolutionParameterf")
    glConvolutionFilter2DPtr = OpenGLExtProcAddress("glConvolutionFilter2D")
    glConvolutionFilter1DPtr = OpenGLExtProcAddress("glConvolutionFilter1D")
    glColorTableParameterivPtr = OpenGLExtProcAddress("glColorTableParameteriv")
    glColorTableParameterfvPtr = OpenGLExtProcAddress("glColorTableParameterfv")
    glColorTablePtr = OpenGLExtProcAddress("glColorTable")
    glColorSubTablePtr = OpenGLExtProcAddress("glColorSubTable")
    glUniform4ui64vARBPtr = OpenGLExtProcAddress("glUniform4ui64vARB")
    glUniform4ui64ARBPtr = OpenGLExtProcAddress("glUniform4ui64ARB")
    glUniform4i64vARBPtr = OpenGLExtProcAddress("glUniform4i64vARB")
    glUniform4i64ARBPtr = OpenGLExtProcAddress("glUniform4i64ARB")
    glUniform3ui64vARBPtr = OpenGLExtProcAddress("glUniform3ui64vARB")
    glUniform3ui64ARBPtr = OpenGLExtProcAddress("glUniform3ui64ARB")
    glUniform3i64vARBPtr = OpenGLExtProcAddress("glUniform3i64vARB")
    glUniform3i64ARBPtr = OpenGLExtProcAddress("glUniform3i64ARB")
    glUniform2ui64vARBPtr = OpenGLExtProcAddress("glUniform2ui64vARB")
    glUniform2ui64ARBPtr = OpenGLExtProcAddress("glUniform2ui64ARB")
    glUniform2i64vARBPtr = OpenGLExtProcAddress("glUniform2i64vARB")
    glUniform2i64ARBPtr = OpenGLExtProcAddress("glUniform2i64ARB")
    glUniform1ui64vARBPtr = OpenGLExtProcAddress("glUniform1ui64vARB")
    glUniform1ui64ARBPtr = OpenGLExtProcAddress("glUniform1ui64ARB")
    glUniform1i64vARBPtr = OpenGLExtProcAddress("glUniform1i64vARB")
    glUniform1i64ARBPtr = OpenGLExtProcAddress("glUniform1i64ARB")
    glProgramUniform4ui64vARBPtr = OpenGLExtProcAddress("glProgramUniform4ui64vARB")
    glProgramUniform4ui64ARBPtr = OpenGLExtProcAddress("glProgramUniform4ui64ARB")
    glProgramUniform4i64vARBPtr = OpenGLExtProcAddress("glProgramUniform4i64vARB")
    glProgramUniform4i64ARBPtr = OpenGLExtProcAddress("glProgramUniform4i64ARB")
    glProgramUniform3ui64vARBPtr = OpenGLExtProcAddress("glProgramUniform3ui64vARB")
    glProgramUniform3ui64ARBPtr = OpenGLExtProcAddress("glProgramUniform3ui64ARB")
    glProgramUniform3i64vARBPtr = OpenGLExtProcAddress("glProgramUniform3i64vARB")
    glProgramUniform3i64ARBPtr = OpenGLExtProcAddress("glProgramUniform3i64ARB")
    glProgramUniform2ui64vARBPtr = OpenGLExtProcAddress("glProgramUniform2ui64vARB")
    glProgramUniform2ui64ARBPtr = OpenGLExtProcAddress("glProgramUniform2ui64ARB")
    glProgramUniform2i64vARBPtr = OpenGLExtProcAddress("glProgramUniform2i64vARB")
    glProgramUniform2i64ARBPtr = OpenGLExtProcAddress("glProgramUniform2i64ARB")
    glProgramUniform1ui64vARBPtr = OpenGLExtProcAddress("glProgramUniform1ui64vARB")
    glProgramUniform1ui64ARBPtr = OpenGLExtProcAddress("glProgramUniform1ui64ARB")
    glProgramUniform1i64vARBPtr = OpenGLExtProcAddress("glProgramUniform1i64vARB")
    glProgramUniform1i64ARBPtr = OpenGLExtProcAddress("glProgramUniform1i64ARB")
    glGetnUniformui64vARBPtr = OpenGLExtProcAddress("glGetnUniformui64vARB")
    glGetnUniformi64vARBPtr = OpenGLExtProcAddress("glGetnUniformi64vARB")
    glGetUniformui64vARBPtr = OpenGLExtProcAddress("glGetUniformui64vARB")
    glGetUniformi64vARBPtr = OpenGLExtProcAddress("glGetUniformi64vARB")
    glUniformMatrix4x3dvPtr = OpenGLExtProcAddress("glUniformMatrix4x3dv")
    glUniformMatrix4x2dvPtr = OpenGLExtProcAddress("glUniformMatrix4x2dv")
    glUniformMatrix4dvPtr = OpenGLExtProcAddress("glUniformMatrix4dv")
    glUniformMatrix3x4dvPtr = OpenGLExtProcAddress("glUniformMatrix3x4dv")
    glUniformMatrix3x2dvPtr = OpenGLExtProcAddress("glUniformMatrix3x2dv")
    glUniformMatrix3dvPtr = OpenGLExtProcAddress("glUniformMatrix3dv")
    glUniformMatrix2x4dvPtr = OpenGLExtProcAddress("glUniformMatrix2x4dv")
    glUniformMatrix2x3dvPtr = OpenGLExtProcAddress("glUniformMatrix2x3dv")
    glUniformMatrix2dvPtr = OpenGLExtProcAddress("glUniformMatrix2dv")
    glUniform4dvPtr = OpenGLExtProcAddress("glUniform4dv")
    glUniform4dPtr = OpenGLExtProcAddress("glUniform4d")
    glUniform3dvPtr = OpenGLExtProcAddress("glUniform3dv")
    glUniform3dPtr = OpenGLExtProcAddress("glUniform3d")
    glUniform2dvPtr = OpenGLExtProcAddress("glUniform2dv")
    glUniform2dPtr = OpenGLExtProcAddress("glUniform2d")
    glUniform1dvPtr = OpenGLExtProcAddress("glUniform1dv")
    glUniform1dPtr = OpenGLExtProcAddress("glUniform1d")
    glGetUniformdvPtr = OpenGLExtProcAddress("glGetUniformdv")
    glSpecializeShaderARBPtr = OpenGLExtProcAddress("glSpecializeShaderARB")
    glGetTextureSubImagePtr = OpenGLExtProcAddress("glGetTextureSubImage")
    glGetCompressedTextureSubImagePtr = OpenGLExtProcAddress("glGetCompressedTextureSubImage")
    glProgramParameteriPtr = OpenGLExtProcAddress("glProgramParameteri")
    glProgramBinaryPtr = OpenGLExtProcAddress("glProgramBinary")
    glGetProgramBinaryPtr = OpenGLExtProcAddress("glGetProgramBinary")
    glProgramParameteriARBPtr = OpenGLExtProcAddress("glProgramParameteriARB")
    glFramebufferTextureLayerARBPtr = OpenGLExtProcAddress("glFramebufferTextureLayerARB")
    glFramebufferTextureFaceARBPtr = OpenGLExtProcAddress("glFramebufferTextureFaceARB")
    glFramebufferTextureARBPtr = OpenGLExtProcAddress("glFramebufferTextureARB")
    glRenderbufferStorageMultisamplePtr = OpenGLExtProcAddress("glRenderbufferStorageMultisample")
    glRenderbufferStoragePtr = OpenGLExtProcAddress("glRenderbufferStorage")
    glIsRenderbufferPtr = OpenGLExtProcAddress("glIsRenderbuffer")
    glIsFramebufferPtr = OpenGLExtProcAddress("glIsFramebuffer")
    glGetRenderbufferParameterivPtr = OpenGLExtProcAddress("glGetRenderbufferParameteriv")
    glGetFramebufferAttachmentParameterivPtr = OpenGLExtProcAddress("glGetFramebufferAttachmentParameteriv")
    glGenerateMipmapPtr = OpenGLExtProcAddress("glGenerateMipmap")
    glGenRenderbuffersPtr = OpenGLExtProcAddress("glGenRenderbuffers")
    glGenFramebuffersPtr = OpenGLExtProcAddress("glGenFramebuffers")
    glFramebufferTextureLayerPtr = OpenGLExtProcAddress("glFramebufferTextureLayer")
    glFramebufferTexture3DPtr = OpenGLExtProcAddress("glFramebufferTexture3D")
    glFramebufferTexture2DPtr = OpenGLExtProcAddress("glFramebufferTexture2D")
    glFramebufferTexture1DPtr = OpenGLExtProcAddress("glFramebufferTexture1D")
    glFramebufferRenderbufferPtr = OpenGLExtProcAddress("glFramebufferRenderbuffer")
    glDeleteRenderbuffersPtr = OpenGLExtProcAddress("glDeleteRenderbuffers")
    glDeleteFramebuffersPtr = OpenGLExtProcAddress("glDeleteFramebuffers")
    glCheckFramebufferStatusPtr = OpenGLExtProcAddress("glCheckFramebufferStatus")
    glBlitFramebufferPtr = OpenGLExtProcAddress("glBlitFramebuffer")
    glBindRenderbufferPtr = OpenGLExtProcAddress("glBindRenderbuffer")
    glBindFramebufferPtr = OpenGLExtProcAddress("glBindFramebuffer")
    glNamedFramebufferParameteriEXTPtr = OpenGLExtProcAddress("glNamedFramebufferParameteriEXT")
    glGetNamedFramebufferParameterivEXTPtr = OpenGLExtProcAddress("glGetNamedFramebufferParameterivEXT")
    glGetFramebufferParameterivPtr = OpenGLExtProcAddress("glGetFramebufferParameteriv")
    glFramebufferParameteriPtr = OpenGLExtProcAddress("glFramebufferParameteri")
    glDrawElementsIndirectPtr = OpenGLExtProcAddress("glDrawElementsIndirect")
    glDrawArraysIndirectPtr = OpenGLExtProcAddress("glDrawArraysIndirect")
    glMultiDrawElementsBaseVertexPtr = OpenGLExtProcAddress("glMultiDrawElementsBaseVertex")
    glDrawRangeElementsBaseVertexPtr = OpenGLExtProcAddress("glDrawRangeElementsBaseVertex")
    glDrawElementsInstancedBaseVertexPtr = OpenGLExtProcAddress("glDrawElementsInstancedBaseVertex")
    glDrawElementsBaseVertexPtr = OpenGLExtProcAddress("glDrawElementsBaseVertex")
    glBlendFunciARBPtr = OpenGLExtProcAddress("glBlendFunciARB")
    glBlendFuncSeparateiARBPtr = OpenGLExtProcAddress("glBlendFuncSeparateiARB")
    glBlendEquationiARBPtr = OpenGLExtProcAddress("glBlendEquationiARB")
    glBlendEquationSeparateiARBPtr = OpenGLExtProcAddress("glBlendEquationSeparateiARB")
    glDrawBuffersARBPtr = OpenGLExtProcAddress("glDrawBuffersARB")
    glVertexArrayVertexBuffersPtr = OpenGLExtProcAddress("glVertexArrayVertexBuffers")
    glVertexArrayVertexBufferPtr = OpenGLExtProcAddress("glVertexArrayVertexBuffer")
    glVertexArrayElementBufferPtr = OpenGLExtProcAddress("glVertexArrayElementBuffer")
    glVertexArrayBindingDivisorPtr = OpenGLExtProcAddress("glVertexArrayBindingDivisor")
    glVertexArrayAttribLFormatPtr = OpenGLExtProcAddress("glVertexArrayAttribLFormat")
    glVertexArrayAttribIFormatPtr = OpenGLExtProcAddress("glVertexArrayAttribIFormat")
    glVertexArrayAttribFormatPtr = OpenGLExtProcAddress("glVertexArrayAttribFormat")
    glVertexArrayAttribBindingPtr = OpenGLExtProcAddress("glVertexArrayAttribBinding")
    glUnmapNamedBufferPtr = OpenGLExtProcAddress("glUnmapNamedBuffer")
    glTransformFeedbackBufferRangePtr = OpenGLExtProcAddress("glTransformFeedbackBufferRange")
    glTransformFeedbackBufferBasePtr = OpenGLExtProcAddress("glTransformFeedbackBufferBase")
    glTextureSubImage3DPtr = OpenGLExtProcAddress("glTextureSubImage3D")
    glTextureSubImage2DPtr = OpenGLExtProcAddress("glTextureSubImage2D")
    glTextureSubImage1DPtr = OpenGLExtProcAddress("glTextureSubImage1D")
    glTextureStorage3DMultisamplePtr = OpenGLExtProcAddress("glTextureStorage3DMultisample")
    glTextureStorage3DPtr = OpenGLExtProcAddress("glTextureStorage3D")
    glTextureStorage2DMultisamplePtr = OpenGLExtProcAddress("glTextureStorage2DMultisample")
    glTextureStorage2DPtr = OpenGLExtProcAddress("glTextureStorage2D")
    glTextureStorage1DPtr = OpenGLExtProcAddress("glTextureStorage1D")
    glTextureParameterivPtr = OpenGLExtProcAddress("glTextureParameteriv")
    glTextureParameteriPtr = OpenGLExtProcAddress("glTextureParameteri")
    glTextureParameterfvPtr = OpenGLExtProcAddress("glTextureParameterfv")
    glTextureParameterfPtr = OpenGLExtProcAddress("glTextureParameterf")
    glTextureParameterIuivPtr = OpenGLExtProcAddress("glTextureParameterIuiv")
    glTextureParameterIivPtr = OpenGLExtProcAddress("glTextureParameterIiv")
    glTextureBufferRangePtr = OpenGLExtProcAddress("glTextureBufferRange")
    glTextureBufferPtr = OpenGLExtProcAddress("glTextureBuffer")
    glNamedRenderbufferStorageMultisamplePtr = OpenGLExtProcAddress("glNamedRenderbufferStorageMultisample")
    glNamedRenderbufferStoragePtr = OpenGLExtProcAddress("glNamedRenderbufferStorage")
    glNamedFramebufferTextureLayerPtr = OpenGLExtProcAddress("glNamedFramebufferTextureLayer")
    glNamedFramebufferTexturePtr = OpenGLExtProcAddress("glNamedFramebufferTexture")
    glNamedFramebufferRenderbufferPtr = OpenGLExtProcAddress("glNamedFramebufferRenderbuffer")
    glNamedFramebufferReadBufferPtr = OpenGLExtProcAddress("glNamedFramebufferReadBuffer")
    glNamedFramebufferParameteriPtr = OpenGLExtProcAddress("glNamedFramebufferParameteri")
    glNamedFramebufferDrawBuffersPtr = OpenGLExtProcAddress("glNamedFramebufferDrawBuffers")
    glNamedFramebufferDrawBufferPtr = OpenGLExtProcAddress("glNamedFramebufferDrawBuffer")
    glNamedBufferSubDataPtr = OpenGLExtProcAddress("glNamedBufferSubData")
    glNamedBufferStoragePtr = OpenGLExtProcAddress("glNamedBufferStorage")
    glNamedBufferDataPtr = OpenGLExtProcAddress("glNamedBufferData")
    glInvalidateNamedFramebufferSubDataPtr = OpenGLExtProcAddress("glInvalidateNamedFramebufferSubData")
    glInvalidateNamedFramebufferDataPtr = OpenGLExtProcAddress("glInvalidateNamedFramebufferData")
    glGetVertexArrayivPtr = OpenGLExtProcAddress("glGetVertexArrayiv")
    glGetVertexArrayIndexedivPtr = OpenGLExtProcAddress("glGetVertexArrayIndexediv")
    glGetVertexArrayIndexed64ivPtr = OpenGLExtProcAddress("glGetVertexArrayIndexed64iv")
    glGetTransformFeedbackivPtr = OpenGLExtProcAddress("glGetTransformFeedbackiv")
    glGetTransformFeedbacki_vPtr = OpenGLExtProcAddress("glGetTransformFeedbacki_v")
    glGetTransformFeedbacki64_vPtr = OpenGLExtProcAddress("glGetTransformFeedbacki64_v")
    glGetTextureParameterivPtr = OpenGLExtProcAddress("glGetTextureParameteriv")
    glGetTextureParameterfvPtr = OpenGLExtProcAddress("glGetTextureParameterfv")
    glGetTextureParameterIuivPtr = OpenGLExtProcAddress("glGetTextureParameterIuiv")
    glGetTextureParameterIivPtr = OpenGLExtProcAddress("glGetTextureParameterIiv")
    glGetTextureLevelParameterivPtr = OpenGLExtProcAddress("glGetTextureLevelParameteriv")
    glGetTextureLevelParameterfvPtr = OpenGLExtProcAddress("glGetTextureLevelParameterfv")
    glGetTextureImagePtr = OpenGLExtProcAddress("glGetTextureImage")
    glGetQueryBufferObjectuivPtr = OpenGLExtProcAddress("glGetQueryBufferObjectuiv")
    glGetQueryBufferObjectui64vPtr = OpenGLExtProcAddress("glGetQueryBufferObjectui64v")
    glGetQueryBufferObjectivPtr = OpenGLExtProcAddress("glGetQueryBufferObjectiv")
    glGetQueryBufferObjecti64vPtr = OpenGLExtProcAddress("glGetQueryBufferObjecti64v")
    glGetNamedRenderbufferParameterivPtr = OpenGLExtProcAddress("glGetNamedRenderbufferParameteriv")
    glGetNamedFramebufferParameterivPtr = OpenGLExtProcAddress("glGetNamedFramebufferParameteriv")
    glGetNamedFramebufferAttachmentParameterivPtr = OpenGLExtProcAddress("glGetNamedFramebufferAttachmentParameteriv")
    glGetNamedBufferSubDataPtr = OpenGLExtProcAddress("glGetNamedBufferSubData")
    glGetNamedBufferPointervPtr = OpenGLExtProcAddress("glGetNamedBufferPointerv")
    glGetNamedBufferParameterivPtr = OpenGLExtProcAddress("glGetNamedBufferParameteriv")
    glGetNamedBufferParameteri64vPtr = OpenGLExtProcAddress("glGetNamedBufferParameteri64v")
    glGetCompressedTextureImagePtr = OpenGLExtProcAddress("glGetCompressedTextureImage")
    glGenerateTextureMipmapPtr = OpenGLExtProcAddress("glGenerateTextureMipmap")
    glFlushMappedNamedBufferRangePtr = OpenGLExtProcAddress("glFlushMappedNamedBufferRange")
    glEnableVertexArrayAttribPtr = OpenGLExtProcAddress("glEnableVertexArrayAttrib")
    glDisableVertexArrayAttribPtr = OpenGLExtProcAddress("glDisableVertexArrayAttrib")
    glCreateVertexArraysPtr = OpenGLExtProcAddress("glCreateVertexArrays")
    glCreateTransformFeedbacksPtr = OpenGLExtProcAddress("glCreateTransformFeedbacks")
    glCreateTexturesPtr = OpenGLExtProcAddress("glCreateTextures")
    glCreateSamplersPtr = OpenGLExtProcAddress("glCreateSamplers")
    glCreateRenderbuffersPtr = OpenGLExtProcAddress("glCreateRenderbuffers")
    glCreateQueriesPtr = OpenGLExtProcAddress("glCreateQueries")
    glCreateProgramPipelinesPtr = OpenGLExtProcAddress("glCreateProgramPipelines")
    glCreateFramebuffersPtr = OpenGLExtProcAddress("glCreateFramebuffers")
    glCreateBuffersPtr = OpenGLExtProcAddress("glCreateBuffers")
    glCopyTextureSubImage3DPtr = OpenGLExtProcAddress("glCopyTextureSubImage3D")
    glCopyTextureSubImage2DPtr = OpenGLExtProcAddress("glCopyTextureSubImage2D")
    glCopyTextureSubImage1DPtr = OpenGLExtProcAddress("glCopyTextureSubImage1D")
    glCopyNamedBufferSubDataPtr = OpenGLExtProcAddress("glCopyNamedBufferSubData")
    glCompressedTextureSubImage3DPtr = OpenGLExtProcAddress("glCompressedTextureSubImage3D")
    glCompressedTextureSubImage2DPtr = OpenGLExtProcAddress("glCompressedTextureSubImage2D")
    glCompressedTextureSubImage1DPtr = OpenGLExtProcAddress("glCompressedTextureSubImage1D")
    glClearNamedFramebufferuivPtr = OpenGLExtProcAddress("glClearNamedFramebufferuiv")
    glClearNamedFramebufferivPtr = OpenGLExtProcAddress("glClearNamedFramebufferiv")
    glClearNamedFramebufferfvPtr = OpenGLExtProcAddress("glClearNamedFramebufferfv")
    glClearNamedFramebufferfiPtr = OpenGLExtProcAddress("glClearNamedFramebufferfi")
    glClearNamedBufferSubDataPtr = OpenGLExtProcAddress("glClearNamedBufferSubData")
    glClearNamedBufferDataPtr = OpenGLExtProcAddress("glClearNamedBufferData")
    glCheckNamedFramebufferStatusPtr = OpenGLExtProcAddress("glCheckNamedFramebufferStatus")
    glBlitNamedFramebufferPtr = OpenGLExtProcAddress("glBlitNamedFramebuffer")
    glBindTextureUnitPtr = OpenGLExtProcAddress("glBindTextureUnit")
    glGetDebugMessageLogARBPtr = OpenGLExtProcAddress("glGetDebugMessageLogARB")
    glDebugMessageInsertARBPtr = OpenGLExtProcAddress("glDebugMessageInsertARB")
    glDebugMessageControlARBPtr = OpenGLExtProcAddress("glDebugMessageControlARB")
    glDebugMessageCallbackARBPtr = OpenGLExtProcAddress("glDebugMessageCallbackARB")
    glCopyImageSubDataPtr = OpenGLExtProcAddress("glCopyImageSubData")
    glCopyBufferSubDataPtr = OpenGLExtProcAddress("glCopyBufferSubData")
    glDispatchComputeGroupSizeARBPtr = OpenGLExtProcAddress("glDispatchComputeGroupSizeARB")
    glDispatchComputeIndirectPtr = OpenGLExtProcAddress("glDispatchComputeIndirect")
    glDispatchComputePtr = OpenGLExtProcAddress("glDispatchCompute")
    glClampColorARBPtr = OpenGLExtProcAddress("glClampColorARB")
    glClipControlPtr = OpenGLExtProcAddress("glClipControl")
    glClearTexSubImagePtr = OpenGLExtProcAddress("glClearTexSubImage")
    glClearTexImagePtr = OpenGLExtProcAddress("glClearTexImage")
    glClearNamedBufferSubDataEXTPtr = OpenGLExtProcAddress("glClearNamedBufferSubDataEXT")
    glClearNamedBufferDataEXTPtr = OpenGLExtProcAddress("glClearNamedBufferDataEXT")
    glClearBufferSubDataPtr = OpenGLExtProcAddress("glClearBufferSubData")
    glClearBufferDataPtr = OpenGLExtProcAddress("glClearBufferData")
    glCreateSyncFromCLeventARBPtr = OpenGLExtProcAddress("glCreateSyncFromCLeventARB")
    glBufferStoragePtr = OpenGLExtProcAddress("glBufferStorage")
    glGetFragDataIndexPtr = OpenGLExtProcAddress("glGetFragDataIndex")
    glBindFragDataLocationIndexedPtr = OpenGLExtProcAddress("glBindFragDataLocationIndexed")
    glVertexAttribL1ui64vARBPtr = OpenGLExtProcAddress("glVertexAttribL1ui64vARB")
    glVertexAttribL1ui64ARBPtr = OpenGLExtProcAddress("glVertexAttribL1ui64ARB")
    glUniformHandleui64vARBPtr = OpenGLExtProcAddress("glUniformHandleui64vARB")
    glUniformHandleui64ARBPtr = OpenGLExtProcAddress("glUniformHandleui64ARB")
    glProgramUniformHandleui64vARBPtr = OpenGLExtProcAddress("glProgramUniformHandleui64vARB")
    glProgramUniformHandleui64ARBPtr = OpenGLExtProcAddress("glProgramUniformHandleui64ARB")
    glMakeTextureHandleResidentARBPtr = OpenGLExtProcAddress("glMakeTextureHandleResidentARB")
    glMakeTextureHandleNonResidentARBPtr = OpenGLExtProcAddress("glMakeTextureHandleNonResidentARB")
    glMakeImageHandleResidentARBPtr = OpenGLExtProcAddress("glMakeImageHandleResidentARB")
    glMakeImageHandleNonResidentARBPtr = OpenGLExtProcAddress("glMakeImageHandleNonResidentARB")
    glIsTextureHandleResidentARBPtr = OpenGLExtProcAddress("glIsTextureHandleResidentARB")
    glIsImageHandleResidentARBPtr = OpenGLExtProcAddress("glIsImageHandleResidentARB")
    glGetVertexAttribLui64vARBPtr = OpenGLExtProcAddress("glGetVertexAttribLui64vARB")
    glGetTextureSamplerHandleARBPtr = OpenGLExtProcAddress("glGetTextureSamplerHandleARB")
    glGetTextureHandleARBPtr = OpenGLExtProcAddress("glGetTextureHandleARB")
    glGetImageHandleARBPtr = OpenGLExtProcAddress("glGetImageHandleARB")
    glDrawElementsInstancedBaseVertexBaseInstancePtr = OpenGLExtProcAddress("glDrawElementsInstancedBaseVertexBaseInstance")
    glDrawElementsInstancedBaseInstancePtr = OpenGLExtProcAddress("glDrawElementsInstancedBaseInstance")
    glDrawArraysInstancedBaseInstancePtr = OpenGLExtProcAddress("glDrawArraysInstancedBaseInstance")
    glPrimitiveBoundingBoxARBPtr = OpenGLExtProcAddress("glPrimitiveBoundingBoxARB")
    glMemoryBarrierByRegionPtr = OpenGLExtProcAddress("glMemoryBarrierByRegion")
    glShaderBinaryPtr = OpenGLExtProcAddress("glShaderBinary")
    glReleaseShaderCompilerPtr = OpenGLExtProcAddress("glReleaseShaderCompiler")
    glGetShaderPrecisionFormatPtr = OpenGLExtProcAddress("glGetShaderPrecisionFormat")
    glDepthRangefPtr = OpenGLExtProcAddress("glDepthRangef")
    glClearDepthfPtr = OpenGLExtProcAddress("glClearDepthf")
Else
    RemapVBFunctionToGLFunction AddressOf glWindowPos3svARB, "glWindowPos3svARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3sARB, "glWindowPos3sARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3ivARB, "glWindowPos3ivARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3iARB, "glWindowPos3iARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3fvARB, "glWindowPos3fvARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3fARB, "glWindowPos3fARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3dvARB, "glWindowPos3dvARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos3dARB, "glWindowPos3dARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2svARB, "glWindowPos2svARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2sARB, "glWindowPos2sARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2ivARB, "glWindowPos2ivARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2iARB, "glWindowPos2iARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2fvARB, "glWindowPos2fvARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2fARB, "glWindowPos2fARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2dvARB, "glWindowPos2dvARB"
    RemapVBFunctionToGLFunction AddressOf glWindowPos2dARB, "glWindowPos2dARB"
    RemapVBFunctionToGLFunction AddressOf glViewportIndexedfv, "glViewportIndexedfv"
    RemapVBFunctionToGLFunction AddressOf glViewportIndexedf, "glViewportIndexedf"
    RemapVBFunctionToGLFunction AddressOf glViewportArrayv, "glViewportArrayv"
    RemapVBFunctionToGLFunction AddressOf glScissorIndexedv, "glScissorIndexedv"
    RemapVBFunctionToGLFunction AddressOf glScissorIndexed, "glScissorIndexed"
    RemapVBFunctionToGLFunction AddressOf glScissorArrayv, "glScissorArrayv"
    RemapVBFunctionToGLFunction AddressOf glGetFloati_v, "glGetFloati_v"
    RemapVBFunctionToGLFunction AddressOf glGetDoublei_v, "glGetDoublei_v"
    RemapVBFunctionToGLFunction AddressOf glDepthRangeIndexed, "glDepthRangeIndexed"
    RemapVBFunctionToGLFunction AddressOf glDepthRangeArrayv, "glDepthRangeArrayv"
    RemapVBFunctionToGLFunction AddressOf glVertexP4uiv, "glVertexP4uiv"
    RemapVBFunctionToGLFunction AddressOf glVertexP4ui, "glVertexP4ui"
    RemapVBFunctionToGLFunction AddressOf glVertexP3uiv, "glVertexP3uiv"
    RemapVBFunctionToGLFunction AddressOf glVertexP3ui, "glVertexP3ui"
    RemapVBFunctionToGLFunction AddressOf glVertexP2uiv, "glVertexP2uiv"
    RemapVBFunctionToGLFunction AddressOf glVertexP2ui, "glVertexP2ui"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribP4uiv, "glVertexAttribP4uiv"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribP4ui, "glVertexAttribP4ui"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribP3uiv, "glVertexAttribP3uiv"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribP3ui, "glVertexAttribP3ui"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribP2uiv, "glVertexAttribP2uiv"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribP2ui, "glVertexAttribP2ui"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribP1uiv, "glVertexAttribP1uiv"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribP1ui, "glVertexAttribP1ui"
    RemapVBFunctionToGLFunction AddressOf glTexCoordP4uiv, "glTexCoordP4uiv"
    RemapVBFunctionToGLFunction AddressOf glTexCoordP4ui, "glTexCoordP4ui"
    RemapVBFunctionToGLFunction AddressOf glTexCoordP3uiv, "glTexCoordP3uiv"
    RemapVBFunctionToGLFunction AddressOf glTexCoordP3ui, "glTexCoordP3ui"
    RemapVBFunctionToGLFunction AddressOf glTexCoordP2uiv, "glTexCoordP2uiv"
    RemapVBFunctionToGLFunction AddressOf glTexCoordP2ui, "glTexCoordP2ui"
    RemapVBFunctionToGLFunction AddressOf glTexCoordP1uiv, "glTexCoordP1uiv"
    RemapVBFunctionToGLFunction AddressOf glTexCoordP1ui, "glTexCoordP1ui"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColorP3uiv, "glSecondaryColorP3uiv"
    RemapVBFunctionToGLFunction AddressOf glSecondaryColorP3ui, "glSecondaryColorP3ui"
    RemapVBFunctionToGLFunction AddressOf glNormalP3uiv, "glNormalP3uiv"
    RemapVBFunctionToGLFunction AddressOf glNormalP3ui, "glNormalP3ui"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoordP4uiv, "glMultiTexCoordP4uiv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoordP4ui, "glMultiTexCoordP4ui"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoordP3uiv, "glMultiTexCoordP3uiv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoordP3ui, "glMultiTexCoordP3ui"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoordP2uiv, "glMultiTexCoordP2uiv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoordP2ui, "glMultiTexCoordP2ui"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoordP1uiv, "glMultiTexCoordP1uiv"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoordP1ui, "glMultiTexCoordP1ui"
    RemapVBFunctionToGLFunction AddressOf glColorP4uiv, "glColorP4uiv"
    RemapVBFunctionToGLFunction AddressOf glColorP4ui, "glColorP4ui"
    RemapVBFunctionToGLFunction AddressOf glColorP3uiv, "glColorP3uiv"
    RemapVBFunctionToGLFunction AddressOf glColorP3ui, "glColorP3ui"
    RemapVBFunctionToGLFunction AddressOf glGetAttribLocationARB, "glGetAttribLocationARB"
    RemapVBFunctionToGLFunction AddressOf glGetActiveAttribARB, "glGetActiveAttribARB"
    RemapVBFunctionToGLFunction AddressOf glBindAttribLocationARB, "glBindAttribLocationARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribPointerARB, "glVertexAttribPointerARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4usvARB, "glVertexAttrib4usvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4uivARB, "glVertexAttrib4uivARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4ubvARB, "glVertexAttrib4ubvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4svARB, "glVertexAttrib4svARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4sARB, "glVertexAttrib4sARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4ivARB, "glVertexAttrib4ivARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4fvARB, "glVertexAttrib4fvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4fARB, "glVertexAttrib4fARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4dvARB, "glVertexAttrib4dvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4dARB, "glVertexAttrib4dARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4bvARB, "glVertexAttrib4bvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4NusvARB, "glVertexAttrib4NusvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4NuivARB, "glVertexAttrib4NuivARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4NubvARB, "glVertexAttrib4NubvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4NubARB, "glVertexAttrib4NubARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4NsvARB, "glVertexAttrib4NsvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4NivARB, "glVertexAttrib4NivARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib4NbvARB, "glVertexAttrib4NbvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib3svARB, "glVertexAttrib3svARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib3sARB, "glVertexAttrib3sARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib3fvARB, "glVertexAttrib3fvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib3fARB, "glVertexAttrib3fARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib3dvARB, "glVertexAttrib3dvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib3dARB, "glVertexAttrib3dARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib2svARB, "glVertexAttrib2svARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib2sARB, "glVertexAttrib2sARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib2fvARB, "glVertexAttrib2fvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib2fARB, "glVertexAttrib2fARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib2dvARB, "glVertexAttrib2dvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib2dARB, "glVertexAttrib2dARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib1svARB, "glVertexAttrib1svARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib1sARB, "glVertexAttrib1sARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib1fvARB, "glVertexAttrib1fvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib1fARB, "glVertexAttrib1fARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib1dvARB, "glVertexAttrib1dvARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttrib1dARB, "glVertexAttrib1dARB"
    RemapVBFunctionToGLFunction AddressOf glProgramStringARB, "glProgramStringARB"
    RemapVBFunctionToGLFunction AddressOf glProgramLocalParameter4fvARB, "glProgramLocalParameter4fvARB"
    RemapVBFunctionToGLFunction AddressOf glProgramLocalParameter4fARB, "glProgramLocalParameter4fARB"
    RemapVBFunctionToGLFunction AddressOf glProgramLocalParameter4dvARB, "glProgramLocalParameter4dvARB"
    RemapVBFunctionToGLFunction AddressOf glProgramLocalParameter4dARB, "glProgramLocalParameter4dARB"
    RemapVBFunctionToGLFunction AddressOf glProgramEnvParameter4fvARB, "glProgramEnvParameter4fvARB"
    RemapVBFunctionToGLFunction AddressOf glProgramEnvParameter4fARB, "glProgramEnvParameter4fARB"
    RemapVBFunctionToGLFunction AddressOf glProgramEnvParameter4dvARB, "glProgramEnvParameter4dvARB"
    RemapVBFunctionToGLFunction AddressOf glProgramEnvParameter4dARB, "glProgramEnvParameter4dARB"
    RemapVBFunctionToGLFunction AddressOf glIsProgramARB, "glIsProgramARB"
    RemapVBFunctionToGLFunction AddressOf glGetVertexAttribivARB, "glGetVertexAttribivARB"
    RemapVBFunctionToGLFunction AddressOf glGetVertexAttribfvARB, "glGetVertexAttribfvARB"
    RemapVBFunctionToGLFunction AddressOf glGetVertexAttribdvARB, "glGetVertexAttribdvARB"
    RemapVBFunctionToGLFunction AddressOf glGetVertexAttribPointervARB, "glGetVertexAttribPointervARB"
    RemapVBFunctionToGLFunction AddressOf glGetProgramivARB, "glGetProgramivARB"
    RemapVBFunctionToGLFunction AddressOf glGetProgramStringARB, "glGetProgramStringARB"
    RemapVBFunctionToGLFunction AddressOf glGetProgramLocalParameterfvARB, "glGetProgramLocalParameterfvARB"
    RemapVBFunctionToGLFunction AddressOf glGetProgramLocalParameterdvARB, "glGetProgramLocalParameterdvARB"
    RemapVBFunctionToGLFunction AddressOf glGetProgramEnvParameterfvARB, "glGetProgramEnvParameterfvARB"
    RemapVBFunctionToGLFunction AddressOf glGetProgramEnvParameterdvARB, "glGetProgramEnvParameterdvARB"
    RemapVBFunctionToGLFunction AddressOf glGenProgramsARB, "glGenProgramsARB"
    RemapVBFunctionToGLFunction AddressOf glEnableVertexAttribArrayARB, "glEnableVertexAttribArrayARB"
    RemapVBFunctionToGLFunction AddressOf glDisableVertexAttribArrayARB, "glDisableVertexAttribArrayARB"
    RemapVBFunctionToGLFunction AddressOf glDeleteProgramsARB, "glDeleteProgramsARB"
    RemapVBFunctionToGLFunction AddressOf glBindProgramARB, "glBindProgramARB"
    RemapVBFunctionToGLFunction AddressOf glUnmapBufferARB, "glUnmapBufferARB"
    RemapVBFunctionToGLFunction AddressOf glIsBufferARB, "glIsBufferARB"
    RemapVBFunctionToGLFunction AddressOf glGetBufferSubDataARB, "glGetBufferSubDataARB"
    RemapVBFunctionToGLFunction AddressOf glGetBufferPointervARB, "glGetBufferPointervARB"
    RemapVBFunctionToGLFunction AddressOf glGetBufferParameterivARB, "glGetBufferParameterivARB"
    RemapVBFunctionToGLFunction AddressOf glGenBuffersARB, "glGenBuffersARB"
    RemapVBFunctionToGLFunction AddressOf glDeleteBuffersARB, "glDeleteBuffersARB"
    RemapVBFunctionToGLFunction AddressOf glBufferSubDataARB, "glBufferSubDataARB"
    RemapVBFunctionToGLFunction AddressOf glBufferDataARB, "glBufferDataARB"
    RemapVBFunctionToGLFunction AddressOf glBindBufferARB, "glBindBufferARB"
    RemapVBFunctionToGLFunction AddressOf glWeightusvARB, "glWeightusvARB"
    RemapVBFunctionToGLFunction AddressOf glWeightuivARB, "glWeightuivARB"
    RemapVBFunctionToGLFunction AddressOf glWeightubvARB, "glWeightubvARB"
    RemapVBFunctionToGLFunction AddressOf glWeightsvARB, "glWeightsvARB"
    RemapVBFunctionToGLFunction AddressOf glWeightivARB, "glWeightivARB"
    RemapVBFunctionToGLFunction AddressOf glWeightfvARB, "glWeightfvARB"
    RemapVBFunctionToGLFunction AddressOf glWeightdvARB, "glWeightdvARB"
    RemapVBFunctionToGLFunction AddressOf glWeightbvARB, "glWeightbvARB"
    RemapVBFunctionToGLFunction AddressOf glWeightPointerARB, "glWeightPointerARB"
    RemapVBFunctionToGLFunction AddressOf glVertexBlendARB, "glVertexBlendARB"
    RemapVBFunctionToGLFunction AddressOf glVertexBindingDivisor, "glVertexBindingDivisor"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribLFormat, "glVertexAttribLFormat"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribIFormat, "glVertexAttribIFormat"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribFormat, "glVertexAttribFormat"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribBinding, "glVertexAttribBinding"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayVertexBindingDivisorEXT, "glVertexArrayVertexBindingDivisorEXT"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayVertexAttribLFormatEXT, "glVertexArrayVertexAttribLFormatEXT"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayVertexAttribIFormatEXT, "glVertexArrayVertexAttribIFormatEXT"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayVertexAttribFormatEXT, "glVertexArrayVertexAttribFormatEXT"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayVertexAttribBindingEXT, "glVertexArrayVertexAttribBindingEXT"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayBindVertexBufferEXT, "glVertexArrayBindVertexBufferEXT"
    RemapVBFunctionToGLFunction AddressOf glBindVertexBuffer, "glBindVertexBuffer"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribLPointer, "glVertexAttribLPointer"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL4dv, "glVertexAttribL4dv"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL4d, "glVertexAttribL4d"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL3dv, "glVertexAttribL3dv"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL3d, "glVertexAttribL3d"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL2dv, "glVertexAttribL2dv"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL2d, "glVertexAttribL2d"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL1dv, "glVertexAttribL1dv"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL1d, "glVertexAttribL1d"
    RemapVBFunctionToGLFunction AddressOf glGetVertexAttribLdv, "glGetVertexAttribLdv"
    RemapVBFunctionToGLFunction AddressOf glIsVertexArrayARB, "glIsVertexArrayARB"
    RemapVBFunctionToGLFunction AddressOf glGenVertexArraysARB, "glGenVertexArraysARB"
    RemapVBFunctionToGLFunction AddressOf glDeleteVertexArraysARB, "glDeleteVertexArraysARB"
    RemapVBFunctionToGLFunction AddressOf glBindVertexArrayARB, "glBindVertexArrayARB"
    RemapVBFunctionToGLFunction AddressOf glUniformBlockBinding, "glUniformBlockBinding"
    RemapVBFunctionToGLFunction AddressOf glGetUniformIndices, "glGetUniformIndices"
    RemapVBFunctionToGLFunction AddressOf glGetUniformBlockIndex, "glGetUniformBlockIndex"
    RemapVBFunctionToGLFunction AddressOf glGetIntegeri_v, "glGetIntegeri_v"
    RemapVBFunctionToGLFunction AddressOf glGetActiveUniformsiv, "glGetActiveUniformsiv"
    RemapVBFunctionToGLFunction AddressOf glGetActiveUniformName, "glGetActiveUniformName"
    RemapVBFunctionToGLFunction AddressOf glGetActiveUniformBlockiv, "glGetActiveUniformBlockiv"
    RemapVBFunctionToGLFunction AddressOf glGetActiveUniformBlockName, "glGetActiveUniformBlockName"
    RemapVBFunctionToGLFunction AddressOf glBindBufferRange, "glBindBufferRange"
    RemapVBFunctionToGLFunction AddressOf glBindBufferBase, "glBindBufferBase"
    RemapVBFunctionToGLFunction AddressOf glMultTransposeMatrixfARB, "glMultTransposeMatrixfARB"
    RemapVBFunctionToGLFunction AddressOf glMultTransposeMatrixdARB, "glMultTransposeMatrixdARB"
    RemapVBFunctionToGLFunction AddressOf glLoadTransposeMatrixfARB, "glLoadTransposeMatrixfARB"
    RemapVBFunctionToGLFunction AddressOf glLoadTransposeMatrixdARB, "glLoadTransposeMatrixdARB"
    RemapVBFunctionToGLFunction AddressOf glDrawTransformFeedbackStreamInstanced, "glDrawTransformFeedbackStreamInstanced"
    RemapVBFunctionToGLFunction AddressOf glDrawTransformFeedbackInstanced, "glDrawTransformFeedbackInstanced"
    RemapVBFunctionToGLFunction AddressOf glGetQueryIndexediv, "glGetQueryIndexediv"
    RemapVBFunctionToGLFunction AddressOf glEndQueryIndexed, "glEndQueryIndexed"
    RemapVBFunctionToGLFunction AddressOf glDrawTransformFeedbackStream, "glDrawTransformFeedbackStream"
    RemapVBFunctionToGLFunction AddressOf glBeginQueryIndexed, "glBeginQueryIndexed"
    RemapVBFunctionToGLFunction AddressOf glResumeTransformFeedback, "glResumeTransformFeedback"
    RemapVBFunctionToGLFunction AddressOf glPauseTransformFeedback, "glPauseTransformFeedback"
    RemapVBFunctionToGLFunction AddressOf glIsTransformFeedback, "glIsTransformFeedback"
    RemapVBFunctionToGLFunction AddressOf glGenTransformFeedbacks, "glGenTransformFeedbacks"
    RemapVBFunctionToGLFunction AddressOf glDrawTransformFeedback, "glDrawTransformFeedback"
    RemapVBFunctionToGLFunction AddressOf glDeleteTransformFeedbacks, "glDeleteTransformFeedbacks"
    RemapVBFunctionToGLFunction AddressOf glBindTransformFeedback, "glBindTransformFeedback"
    RemapVBFunctionToGLFunction AddressOf glQueryCounter, "glQueryCounter"
    RemapVBFunctionToGLFunction AddressOf glGetQueryObjectui64v, "glGetQueryObjectui64v"
    RemapVBFunctionToGLFunction AddressOf glGetQueryObjecti64v, "glGetQueryObjecti64v"
    RemapVBFunctionToGLFunction AddressOf glTextureView, "glTextureView"
    RemapVBFunctionToGLFunction AddressOf glTextureStorage3DMultisampleEXT, "glTextureStorage3DMultisampleEXT"
    RemapVBFunctionToGLFunction AddressOf glTextureStorage2DMultisampleEXT, "glTextureStorage2DMultisampleEXT"
    RemapVBFunctionToGLFunction AddressOf glTexStorage3DMultisample, "glTexStorage3DMultisample"
    RemapVBFunctionToGLFunction AddressOf glTexStorage2DMultisample, "glTexStorage2DMultisample"
    RemapVBFunctionToGLFunction AddressOf glTexStorage3D, "glTexStorage3D"
    RemapVBFunctionToGLFunction AddressOf glTexStorage2D, "glTexStorage2D"
    RemapVBFunctionToGLFunction AddressOf glTexStorage1D, "glTexStorage1D"
    RemapVBFunctionToGLFunction AddressOf glTexImage3DMultisample, "glTexImage3DMultisample"
    RemapVBFunctionToGLFunction AddressOf glTexImage2DMultisample, "glTexImage2DMultisample"
    RemapVBFunctionToGLFunction AddressOf glSampleMaski, "glSampleMaski"
    RemapVBFunctionToGLFunction AddressOf glGetMultisamplefv, "glGetMultisamplefv"
    RemapVBFunctionToGLFunction AddressOf glGetCompressedTexImageARB, "glGetCompressedTexImageARB"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexSubImage3DARB, "glCompressedTexSubImage3DARB"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexSubImage2DARB, "glCompressedTexSubImage2DARB"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexSubImage1DARB, "glCompressedTexSubImage1DARB"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexImage3DARB, "glCompressedTexImage3DARB"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexImage2DARB, "glCompressedTexImage2DARB"
    RemapVBFunctionToGLFunction AddressOf glCompressedTexImage1DARB, "glCompressedTexImage1DARB"
    RemapVBFunctionToGLFunction AddressOf glTextureBufferRangeEXT, "glTextureBufferRangeEXT"
    RemapVBFunctionToGLFunction AddressOf glTexBufferRange, "glTexBufferRange"
    RemapVBFunctionToGLFunction AddressOf glTexBufferARB, "glTexBufferARB"
    RemapVBFunctionToGLFunction AddressOf glTextureBarrier, "glTextureBarrier"
    RemapVBFunctionToGLFunction AddressOf glPatchParameteri, "glPatchParameteri"
    RemapVBFunctionToGLFunction AddressOf glPatchParameterfv, "glPatchParameterfv"
    RemapVBFunctionToGLFunction AddressOf glWaitSync, "glWaitSync"
    RemapVBFunctionToGLFunction AddressOf glIsSync, "glIsSync"
    RemapVBFunctionToGLFunction AddressOf glGetSynciv, "glGetSynciv"
    RemapVBFunctionToGLFunction AddressOf glGetInteger64v, "glGetInteger64v"
    RemapVBFunctionToGLFunction AddressOf glFenceSync, "glFenceSync"
    RemapVBFunctionToGLFunction AddressOf glDeleteSync, "glDeleteSync"
    RemapVBFunctionToGLFunction AddressOf glClientWaitSync, "glClientWaitSync"
    RemapVBFunctionToGLFunction AddressOf glTexPageCommitmentARB, "glTexPageCommitmentARB"
    RemapVBFunctionToGLFunction AddressOf glBufferPageCommitmentARB, "glBufferPageCommitmentARB"
    RemapVBFunctionToGLFunction AddressOf glNamedStringARB, "glNamedStringARB"
    RemapVBFunctionToGLFunction AddressOf glIsNamedStringARB, "glIsNamedStringARB"
    RemapVBFunctionToGLFunction AddressOf glGetNamedStringivARB, "glGetNamedStringivARB"
    RemapVBFunctionToGLFunction AddressOf glGetNamedStringARB, "glGetNamedStringARB"
    RemapVBFunctionToGLFunction AddressOf glDeleteNamedStringARB, "glDeleteNamedStringARB"
    RemapVBFunctionToGLFunction AddressOf glCompileShaderIncludeARB, "glCompileShaderIncludeARB"
    RemapVBFunctionToGLFunction AddressOf glUniformSubroutinesuiv, "glUniformSubroutinesuiv"
    RemapVBFunctionToGLFunction AddressOf glGetUniformSubroutineuiv, "glGetUniformSubroutineuiv"
    RemapVBFunctionToGLFunction AddressOf glGetSubroutineUniformLocation, "glGetSubroutineUniformLocation"
    RemapVBFunctionToGLFunction AddressOf glGetSubroutineIndex, "glGetSubroutineIndex"
    RemapVBFunctionToGLFunction AddressOf glGetProgramStageiv, "glGetProgramStageiv"
    RemapVBFunctionToGLFunction AddressOf glGetActiveSubroutineUniformiv, "glGetActiveSubroutineUniformiv"
    RemapVBFunctionToGLFunction AddressOf glGetActiveSubroutineUniformName, "glGetActiveSubroutineUniformName"
    RemapVBFunctionToGLFunction AddressOf glGetActiveSubroutineName, "glGetActiveSubroutineName"
    RemapVBFunctionToGLFunction AddressOf glShaderStorageBlockBinding, "glShaderStorageBlockBinding"
    RemapVBFunctionToGLFunction AddressOf glValidateProgramARB, "glValidateProgramARB"
    RemapVBFunctionToGLFunction AddressOf glUseProgramObjectARB, "glUseProgramObjectARB"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix4fvARB, "glUniformMatrix4fvARB"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix3fvARB, "glUniformMatrix3fvARB"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix2fvARB, "glUniformMatrix2fvARB"
    RemapVBFunctionToGLFunction AddressOf glUniform4ivARB, "glUniform4ivARB"
    RemapVBFunctionToGLFunction AddressOf glUniform4iARB, "glUniform4iARB"
    RemapVBFunctionToGLFunction AddressOf glUniform4fvARB, "glUniform4fvARB"
    RemapVBFunctionToGLFunction AddressOf glUniform4fARB, "glUniform4fARB"
    RemapVBFunctionToGLFunction AddressOf glUniform3ivARB, "glUniform3ivARB"
    RemapVBFunctionToGLFunction AddressOf glUniform3iARB, "glUniform3iARB"
    RemapVBFunctionToGLFunction AddressOf glUniform3fvARB, "glUniform3fvARB"
    RemapVBFunctionToGLFunction AddressOf glUniform3fARB, "glUniform3fARB"
    RemapVBFunctionToGLFunction AddressOf glUniform2ivARB, "glUniform2ivARB"
    RemapVBFunctionToGLFunction AddressOf glUniform2iARB, "glUniform2iARB"
    RemapVBFunctionToGLFunction AddressOf glUniform2fvARB, "glUniform2fvARB"
    RemapVBFunctionToGLFunction AddressOf glUniform2fARB, "glUniform2fARB"
    RemapVBFunctionToGLFunction AddressOf glUniform1ivARB, "glUniform1ivARB"
    RemapVBFunctionToGLFunction AddressOf glUniform1iARB, "glUniform1iARB"
    RemapVBFunctionToGLFunction AddressOf glUniform1fvARB, "glUniform1fvARB"
    RemapVBFunctionToGLFunction AddressOf glUniform1fARB, "glUniform1fARB"
    RemapVBFunctionToGLFunction AddressOf glShaderSourceARB, "glShaderSourceARB"
    RemapVBFunctionToGLFunction AddressOf glLinkProgramARB, "glLinkProgramARB"
    RemapVBFunctionToGLFunction AddressOf glGetUniformivARB, "glGetUniformivARB"
    RemapVBFunctionToGLFunction AddressOf glGetUniformfvARB, "glGetUniformfvARB"
    RemapVBFunctionToGLFunction AddressOf glGetUniformLocationARB, "glGetUniformLocationARB"
    RemapVBFunctionToGLFunction AddressOf glGetShaderSourceARB, "glGetShaderSourceARB"
    RemapVBFunctionToGLFunction AddressOf glGetObjectParameterivARB, "glGetObjectParameterivARB"
    RemapVBFunctionToGLFunction AddressOf glGetObjectParameterfvARB, "glGetObjectParameterfvARB"
    RemapVBFunctionToGLFunction AddressOf glGetInfoLogARB, "glGetInfoLogARB"
    RemapVBFunctionToGLFunction AddressOf glGetHandleARB, "glGetHandleARB"
    RemapVBFunctionToGLFunction AddressOf glGetAttachedObjectsARB, "glGetAttachedObjectsARB"
    RemapVBFunctionToGLFunction AddressOf glGetActiveUniformARB, "glGetActiveUniformARB"
    RemapVBFunctionToGLFunction AddressOf glDetachObjectARB, "glDetachObjectARB"
    RemapVBFunctionToGLFunction AddressOf glDeleteObjectARB, "glDeleteObjectARB"
    RemapVBFunctionToGLFunction AddressOf glCreateShaderObjectARB, "glCreateShaderObjectARB"
    RemapVBFunctionToGLFunction AddressOf glCreateProgramObjectARB, "glCreateProgramObjectARB"
    RemapVBFunctionToGLFunction AddressOf glCompileShaderARB, "glCompileShaderARB"
    RemapVBFunctionToGLFunction AddressOf glAttachObjectARB, "glAttachObjectARB"
    RemapVBFunctionToGLFunction AddressOf glMemoryBarrier, "glMemoryBarrier"
    RemapVBFunctionToGLFunction AddressOf glBindImageTexture, "glBindImageTexture"
    RemapVBFunctionToGLFunction AddressOf glGetActiveAtomicCounterBufferiv, "glGetActiveAtomicCounterBufferiv"
    RemapVBFunctionToGLFunction AddressOf glValidateProgramPipeline, "glValidateProgramPipeline"
    RemapVBFunctionToGLFunction AddressOf glUseProgramStages, "glUseProgramStages"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix4x3fv, "glProgramUniformMatrix4x3fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix4x3dv, "glProgramUniformMatrix4x3dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix4x2fv, "glProgramUniformMatrix4x2fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix4x2dv, "glProgramUniformMatrix4x2dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix4fv, "glProgramUniformMatrix4fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix4dv, "glProgramUniformMatrix4dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix3x4fv, "glProgramUniformMatrix3x4fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix3x4dv, "glProgramUniformMatrix3x4dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix3x2fv, "glProgramUniformMatrix3x2fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix3x2dv, "glProgramUniformMatrix3x2dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix3fv, "glProgramUniformMatrix3fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix3dv, "glProgramUniformMatrix3dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix2x4fv, "glProgramUniformMatrix2x4fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix2x4dv, "glProgramUniformMatrix2x4dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix2x3fv, "glProgramUniformMatrix2x3fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix2x3dv, "glProgramUniformMatrix2x3dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix2fv, "glProgramUniformMatrix2fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformMatrix2dv, "glProgramUniformMatrix2dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4uiv, "glProgramUniform4uiv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4ui, "glProgramUniform4ui"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4iv, "glProgramUniform4iv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4i, "glProgramUniform4i"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4fv, "glProgramUniform4fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4f, "glProgramUniform4f"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4dv, "glProgramUniform4dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4d, "glProgramUniform4d"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3uiv, "glProgramUniform3uiv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3ui, "glProgramUniform3ui"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3iv, "glProgramUniform3iv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3i, "glProgramUniform3i"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3fv, "glProgramUniform3fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3f, "glProgramUniform3f"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3dv, "glProgramUniform3dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3d, "glProgramUniform3d"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2uiv, "glProgramUniform2uiv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2ui, "glProgramUniform2ui"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2iv, "glProgramUniform2iv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2i, "glProgramUniform2i"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2fv, "glProgramUniform2fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2f, "glProgramUniform2f"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2dv, "glProgramUniform2dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2d, "glProgramUniform2d"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1uiv, "glProgramUniform1uiv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1ui, "glProgramUniform1ui"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1iv, "glProgramUniform1iv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1i, "glProgramUniform1i"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1fv, "glProgramUniform1fv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1f, "glProgramUniform1f"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1dv, "glProgramUniform1dv"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1d, "glProgramUniform1d"
    RemapVBFunctionToGLFunction AddressOf glIsProgramPipeline, "glIsProgramPipeline"
    RemapVBFunctionToGLFunction AddressOf glGetProgramPipelineiv, "glGetProgramPipelineiv"
    RemapVBFunctionToGLFunction AddressOf glGetProgramPipelineInfoLog, "glGetProgramPipelineInfoLog"
    RemapVBFunctionToGLFunction AddressOf glGenProgramPipelines, "glGenProgramPipelines"
    RemapVBFunctionToGLFunction AddressOf glDeleteProgramPipelines, "glDeleteProgramPipelines"
    RemapVBFunctionToGLFunction AddressOf glCreateShaderProgramv, "glCreateShaderProgramv"
    RemapVBFunctionToGLFunction AddressOf glBindProgramPipeline, "glBindProgramPipeline"
    RemapVBFunctionToGLFunction AddressOf glActiveShaderProgram, "glActiveShaderProgram"
    RemapVBFunctionToGLFunction AddressOf glSamplerParameteriv, "glSamplerParameteriv"
    RemapVBFunctionToGLFunction AddressOf glSamplerParameteri, "glSamplerParameteri"
    RemapVBFunctionToGLFunction AddressOf glSamplerParameterfv, "glSamplerParameterfv"
    RemapVBFunctionToGLFunction AddressOf glSamplerParameterf, "glSamplerParameterf"
    RemapVBFunctionToGLFunction AddressOf glSamplerParameterIuiv, "glSamplerParameterIuiv"
    RemapVBFunctionToGLFunction AddressOf glSamplerParameterIiv, "glSamplerParameterIiv"
    RemapVBFunctionToGLFunction AddressOf glIsSampler, "glIsSampler"
    RemapVBFunctionToGLFunction AddressOf glGetSamplerParameteriv, "glGetSamplerParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetSamplerParameterfv, "glGetSamplerParameterfv"
    RemapVBFunctionToGLFunction AddressOf glGetSamplerParameterIuiv, "glGetSamplerParameterIuiv"
    RemapVBFunctionToGLFunction AddressOf glGetSamplerParameterIiv, "glGetSamplerParameterIiv"
    RemapVBFunctionToGLFunction AddressOf glGenSamplers, "glGenSamplers"
    RemapVBFunctionToGLFunction AddressOf glDeleteSamplers, "glDeleteSamplers"
    RemapVBFunctionToGLFunction AddressOf glBindSampler, "glBindSampler"
    RemapVBFunctionToGLFunction AddressOf glMinSampleShadingARB, "glMinSampleShadingARB"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferSampleLocationsfvARB, "glNamedFramebufferSampleLocationsfvARB"
    RemapVBFunctionToGLFunction AddressOf glFramebufferSampleLocationsfvARB, "glFramebufferSampleLocationsfvARB"
    RemapVBFunctionToGLFunction AddressOf glReadnPixelsARB, "glReadnPixelsARB"
    RemapVBFunctionToGLFunction AddressOf glGetnUniformuivARB, "glGetnUniformuivARB"
    RemapVBFunctionToGLFunction AddressOf glGetnUniformivARB, "glGetnUniformivARB"
    RemapVBFunctionToGLFunction AddressOf glGetnUniformfvARB, "glGetnUniformfvARB"
    RemapVBFunctionToGLFunction AddressOf glGetnUniformdvARB, "glGetnUniformdvARB"
    RemapVBFunctionToGLFunction AddressOf glGetnTexImageARB, "glGetnTexImageARB"
    RemapVBFunctionToGLFunction AddressOf glGetnSeparableFilterARB, "glGetnSeparableFilterARB"
    RemapVBFunctionToGLFunction AddressOf glGetnPolygonStippleARB, "glGetnPolygonStippleARB"
    RemapVBFunctionToGLFunction AddressOf glGetnPixelMapusvARB, "glGetnPixelMapusvARB"
    RemapVBFunctionToGLFunction AddressOf glGetnPixelMapuivARB, "glGetnPixelMapuivARB"
    RemapVBFunctionToGLFunction AddressOf glGetnPixelMapfvARB, "glGetnPixelMapfvARB"
    RemapVBFunctionToGLFunction AddressOf glGetnMinmaxARB, "glGetnMinmaxARB"
    RemapVBFunctionToGLFunction AddressOf glGetnMapivARB, "glGetnMapivARB"
    RemapVBFunctionToGLFunction AddressOf glGetnMapfvARB, "glGetnMapfvARB"
    RemapVBFunctionToGLFunction AddressOf glGetnMapdvARB, "glGetnMapdvARB"
    RemapVBFunctionToGLFunction AddressOf glGetnHistogramARB, "glGetnHistogramARB"
    RemapVBFunctionToGLFunction AddressOf glGetnConvolutionFilterARB, "glGetnConvolutionFilterARB"
    RemapVBFunctionToGLFunction AddressOf glGetnCompressedTexImageARB, "glGetnCompressedTexImageARB"
    RemapVBFunctionToGLFunction AddressOf glGetnColorTableARB, "glGetnColorTableARB"
    RemapVBFunctionToGLFunction AddressOf glGetGraphicsResetStatusARB, "glGetGraphicsResetStatusARB"
    RemapVBFunctionToGLFunction AddressOf glProvokingVertex, "glProvokingVertex"
    RemapVBFunctionToGLFunction AddressOf glGetProgramResourceiv, "glGetProgramResourceiv"
    RemapVBFunctionToGLFunction AddressOf glGetProgramResourceName, "glGetProgramResourceName"
    RemapVBFunctionToGLFunction AddressOf glGetProgramResourceLocationIndex, "glGetProgramResourceLocationIndex"
    RemapVBFunctionToGLFunction AddressOf glGetProgramResourceLocation, "glGetProgramResourceLocation"
    RemapVBFunctionToGLFunction AddressOf glGetProgramResourceIndex, "glGetProgramResourceIndex"
    RemapVBFunctionToGLFunction AddressOf glGetProgramInterfaceiv, "glGetProgramInterfaceiv"
    RemapVBFunctionToGLFunction AddressOf glPolygonOffsetClamp, "glPolygonOffsetClamp"
    RemapVBFunctionToGLFunction AddressOf glPointParameterfvARB, "glPointParameterfvARB"
    RemapVBFunctionToGLFunction AddressOf glPointParameterfARB, "glPointParameterfARB"
    RemapVBFunctionToGLFunction AddressOf glMaxShaderCompilerThreadsARB, "glMaxShaderCompilerThreadsARB"
    RemapVBFunctionToGLFunction AddressOf glIsQueryARB, "glIsQueryARB"
    RemapVBFunctionToGLFunction AddressOf glGetQueryivARB, "glGetQueryivARB"
    RemapVBFunctionToGLFunction AddressOf glGetQueryObjectuivARB, "glGetQueryObjectuivARB"
    RemapVBFunctionToGLFunction AddressOf glGetQueryObjectivARB, "glGetQueryObjectivARB"
    RemapVBFunctionToGLFunction AddressOf glGenQueriesARB, "glGenQueriesARB"
    RemapVBFunctionToGLFunction AddressOf glEndQueryARB, "glEndQueryARB"
    RemapVBFunctionToGLFunction AddressOf glDeleteQueriesARB, "glDeleteQueriesARB"
    RemapVBFunctionToGLFunction AddressOf glBeginQueryARB, "glBeginQueryARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4svARB, "glMultiTexCoord4svARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4sARB, "glMultiTexCoord4sARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4ivARB, "glMultiTexCoord4ivARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4iARB, "glMultiTexCoord4iARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4fvARB, "glMultiTexCoord4fvARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4fARB, "glMultiTexCoord4fARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4dvARB, "glMultiTexCoord4dvARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord4dARB, "glMultiTexCoord4dARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3svARB, "glMultiTexCoord3svARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3sARB, "glMultiTexCoord3sARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3ivARB, "glMultiTexCoord3ivARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3iARB, "glMultiTexCoord3iARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3fvARB, "glMultiTexCoord3fvARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3fARB, "glMultiTexCoord3fARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3dvARB, "glMultiTexCoord3dvARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord3dARB, "glMultiTexCoord3dARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2svARB, "glMultiTexCoord2svARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2sARB, "glMultiTexCoord2sARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2ivARB, "glMultiTexCoord2ivARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2iARB, "glMultiTexCoord2iARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2fvARB, "glMultiTexCoord2fvARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2fARB, "glMultiTexCoord2fARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2dvARB, "glMultiTexCoord2dvARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord2dARB, "glMultiTexCoord2dARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1svARB, "glMultiTexCoord1svARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1sARB, "glMultiTexCoord1sARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1ivARB, "glMultiTexCoord1ivARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1iARB, "glMultiTexCoord1iARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1fvARB, "glMultiTexCoord1fvARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1fARB, "glMultiTexCoord1fARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1dvARB, "glMultiTexCoord1dvARB"
    RemapVBFunctionToGLFunction AddressOf glMultiTexCoord1dARB, "glMultiTexCoord1dARB"
    RemapVBFunctionToGLFunction AddressOf glClientActiveTextureARB, "glClientActiveTextureARB"
    RemapVBFunctionToGLFunction AddressOf glActiveTextureARB, "glActiveTextureARB"
    RemapVBFunctionToGLFunction AddressOf glSampleCoverageARB, "glSampleCoverageARB"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawElementsIndirect, "glMultiDrawElementsIndirect"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawArraysIndirect, "glMultiDrawArraysIndirect"
    RemapVBFunctionToGLFunction AddressOf glBindVertexBuffers, "glBindVertexBuffers"
    RemapVBFunctionToGLFunction AddressOf glBindTextures, "glBindTextures"
    RemapVBFunctionToGLFunction AddressOf glBindSamplers, "glBindSamplers"
    RemapVBFunctionToGLFunction AddressOf glBindImageTextures, "glBindImageTextures"
    RemapVBFunctionToGLFunction AddressOf glBindBuffersRange, "glBindBuffersRange"
    RemapVBFunctionToGLFunction AddressOf glBindBuffersBase, "glBindBuffersBase"
    RemapVBFunctionToGLFunction AddressOf glMatrixIndexusvARB, "glMatrixIndexusvARB"
    RemapVBFunctionToGLFunction AddressOf glMatrixIndexuivARB, "glMatrixIndexuivARB"
    RemapVBFunctionToGLFunction AddressOf glMatrixIndexubvARB, "glMatrixIndexubvARB"
    RemapVBFunctionToGLFunction AddressOf glMatrixIndexPointerARB, "glMatrixIndexPointerARB"
    RemapVBFunctionToGLFunction AddressOf glCurrentPaletteMatrixARB, "glCurrentPaletteMatrixARB"
    RemapVBFunctionToGLFunction AddressOf glFlushMappedBufferRange, "glFlushMappedBufferRange"
    RemapVBFunctionToGLFunction AddressOf glInvalidateTexSubImage, "glInvalidateTexSubImage"
    RemapVBFunctionToGLFunction AddressOf glInvalidateTexImage, "glInvalidateTexImage"
    RemapVBFunctionToGLFunction AddressOf glInvalidateSubFramebuffer, "glInvalidateSubFramebuffer"
    RemapVBFunctionToGLFunction AddressOf glInvalidateFramebuffer, "glInvalidateFramebuffer"
    RemapVBFunctionToGLFunction AddressOf glInvalidateBufferSubData, "glInvalidateBufferSubData"
    RemapVBFunctionToGLFunction AddressOf glInvalidateBufferData, "glInvalidateBufferData"
    RemapVBFunctionToGLFunction AddressOf glGetInternalformati64v, "glGetInternalformati64v"
    RemapVBFunctionToGLFunction AddressOf glGetInternalformativ, "glGetInternalformativ"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribDivisorARB, "glVertexAttribDivisorARB"
    RemapVBFunctionToGLFunction AddressOf glDrawElementsInstancedARB, "glDrawElementsInstancedARB"
    RemapVBFunctionToGLFunction AddressOf glDrawArraysInstancedARB, "glDrawArraysInstancedARB"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawElementsIndirectCountARB, "glMultiDrawElementsIndirectCountARB"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawArraysIndirectCountARB, "glMultiDrawArraysIndirectCountARB"
    RemapVBFunctionToGLFunction AddressOf glSeparableFilter2D, "glSeparableFilter2D"
    RemapVBFunctionToGLFunction AddressOf glResetMinmax, "glResetMinmax"
    RemapVBFunctionToGLFunction AddressOf glResetHistogram, "glResetHistogram"
    RemapVBFunctionToGLFunction AddressOf glMinmax, "glMinmax"
    RemapVBFunctionToGLFunction AddressOf glHistogram, "glHistogram"
    RemapVBFunctionToGLFunction AddressOf glGetSeparableFilter, "glGetSeparableFilter"
    RemapVBFunctionToGLFunction AddressOf glGetMinmaxParameteriv, "glGetMinmaxParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetMinmaxParameterfv, "glGetMinmaxParameterfv"
    RemapVBFunctionToGLFunction AddressOf glGetMinmax, "glGetMinmax"
    RemapVBFunctionToGLFunction AddressOf glGetHistogramParameteriv, "glGetHistogramParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetHistogramParameterfv, "glGetHistogramParameterfv"
    RemapVBFunctionToGLFunction AddressOf glGetHistogram, "glGetHistogram"
    RemapVBFunctionToGLFunction AddressOf glGetConvolutionParameteriv, "glGetConvolutionParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetConvolutionParameterfv, "glGetConvolutionParameterfv"
    RemapVBFunctionToGLFunction AddressOf glGetConvolutionFilter, "glGetConvolutionFilter"
    RemapVBFunctionToGLFunction AddressOf glGetColorTableParameteriv, "glGetColorTableParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetColorTableParameterfv, "glGetColorTableParameterfv"
    RemapVBFunctionToGLFunction AddressOf glGetColorTable, "glGetColorTable"
    RemapVBFunctionToGLFunction AddressOf glCopyConvolutionFilter2D, "glCopyConvolutionFilter2D"
    RemapVBFunctionToGLFunction AddressOf glCopyConvolutionFilter1D, "glCopyConvolutionFilter1D"
    RemapVBFunctionToGLFunction AddressOf glCopyColorTable, "glCopyColorTable"
    RemapVBFunctionToGLFunction AddressOf glCopyColorSubTable, "glCopyColorSubTable"
    RemapVBFunctionToGLFunction AddressOf glConvolutionParameteriv, "glConvolutionParameteriv"
    RemapVBFunctionToGLFunction AddressOf glConvolutionParameteri, "glConvolutionParameteri"
    RemapVBFunctionToGLFunction AddressOf glConvolutionParameterfv, "glConvolutionParameterfv"
    RemapVBFunctionToGLFunction AddressOf glConvolutionParameterf, "glConvolutionParameterf"
    RemapVBFunctionToGLFunction AddressOf glConvolutionFilter2D, "glConvolutionFilter2D"
    RemapVBFunctionToGLFunction AddressOf glConvolutionFilter1D, "glConvolutionFilter1D"
    RemapVBFunctionToGLFunction AddressOf glColorTableParameteriv, "glColorTableParameteriv"
    RemapVBFunctionToGLFunction AddressOf glColorTableParameterfv, "glColorTableParameterfv"
    RemapVBFunctionToGLFunction AddressOf glColorTable, "glColorTable"
    RemapVBFunctionToGLFunction AddressOf glColorSubTable, "glColorSubTable"
    RemapVBFunctionToGLFunction AddressOf glUniform4ui64vARB, "glUniform4ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniform4ui64ARB, "glUniform4ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glUniform4i64vARB, "glUniform4i64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniform4i64ARB, "glUniform4i64ARB"
    RemapVBFunctionToGLFunction AddressOf glUniform3ui64vARB, "glUniform3ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniform3ui64ARB, "glUniform3ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glUniform3i64vARB, "glUniform3i64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniform3i64ARB, "glUniform3i64ARB"
    RemapVBFunctionToGLFunction AddressOf glUniform2ui64vARB, "glUniform2ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniform2ui64ARB, "glUniform2ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glUniform2i64vARB, "glUniform2i64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniform2i64ARB, "glUniform2i64ARB"
    RemapVBFunctionToGLFunction AddressOf glUniform1ui64vARB, "glUniform1ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniform1ui64ARB, "glUniform1ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glUniform1i64vARB, "glUniform1i64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniform1i64ARB, "glUniform1i64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4ui64vARB, "glProgramUniform4ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4ui64ARB, "glProgramUniform4ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4i64vARB, "glProgramUniform4i64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform4i64ARB, "glProgramUniform4i64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3ui64vARB, "glProgramUniform3ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3ui64ARB, "glProgramUniform3ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3i64vARB, "glProgramUniform3i64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform3i64ARB, "glProgramUniform3i64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2ui64vARB, "glProgramUniform2ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2ui64ARB, "glProgramUniform2ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2i64vARB, "glProgramUniform2i64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform2i64ARB, "glProgramUniform2i64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1ui64vARB, "glProgramUniform1ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1ui64ARB, "glProgramUniform1ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1i64vARB, "glProgramUniform1i64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniform1i64ARB, "glProgramUniform1i64ARB"
    RemapVBFunctionToGLFunction AddressOf glGetnUniformui64vARB, "glGetnUniformui64vARB"
    RemapVBFunctionToGLFunction AddressOf glGetnUniformi64vARB, "glGetnUniformi64vARB"
    RemapVBFunctionToGLFunction AddressOf glGetUniformui64vARB, "glGetUniformui64vARB"
    RemapVBFunctionToGLFunction AddressOf glGetUniformi64vARB, "glGetUniformi64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix4x3dv, "glUniformMatrix4x3dv"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix4x2dv, "glUniformMatrix4x2dv"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix4dv, "glUniformMatrix4dv"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix3x4dv, "glUniformMatrix3x4dv"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix3x2dv, "glUniformMatrix3x2dv"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix3dv, "glUniformMatrix3dv"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix2x4dv, "glUniformMatrix2x4dv"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix2x3dv, "glUniformMatrix2x3dv"
    RemapVBFunctionToGLFunction AddressOf glUniformMatrix2dv, "glUniformMatrix2dv"
    RemapVBFunctionToGLFunction AddressOf glUniform4dv, "glUniform4dv"
    RemapVBFunctionToGLFunction AddressOf glUniform4d, "glUniform4d"
    RemapVBFunctionToGLFunction AddressOf glUniform3dv, "glUniform3dv"
    RemapVBFunctionToGLFunction AddressOf glUniform3d, "glUniform3d"
    RemapVBFunctionToGLFunction AddressOf glUniform2dv, "glUniform2dv"
    RemapVBFunctionToGLFunction AddressOf glUniform2d, "glUniform2d"
    RemapVBFunctionToGLFunction AddressOf glUniform1dv, "glUniform1dv"
    RemapVBFunctionToGLFunction AddressOf glUniform1d, "glUniform1d"
    RemapVBFunctionToGLFunction AddressOf glGetUniformdv, "glGetUniformdv"
    RemapVBFunctionToGLFunction AddressOf glSpecializeShaderARB, "glSpecializeShaderARB"
    RemapVBFunctionToGLFunction AddressOf glGetTextureSubImage, "glGetTextureSubImage"
    RemapVBFunctionToGLFunction AddressOf glGetCompressedTextureSubImage, "glGetCompressedTextureSubImage"
    RemapVBFunctionToGLFunction AddressOf glProgramParameteri, "glProgramParameteri"
    RemapVBFunctionToGLFunction AddressOf glProgramBinary, "glProgramBinary"
    RemapVBFunctionToGLFunction AddressOf glGetProgramBinary, "glGetProgramBinary"
    RemapVBFunctionToGLFunction AddressOf glProgramParameteriARB, "glProgramParameteriARB"
    RemapVBFunctionToGLFunction AddressOf glFramebufferTextureLayerARB, "glFramebufferTextureLayerARB"
    RemapVBFunctionToGLFunction AddressOf glFramebufferTextureFaceARB, "glFramebufferTextureFaceARB"
    RemapVBFunctionToGLFunction AddressOf glFramebufferTextureARB, "glFramebufferTextureARB"
    RemapVBFunctionToGLFunction AddressOf glRenderbufferStorageMultisample, "glRenderbufferStorageMultisample"
    RemapVBFunctionToGLFunction AddressOf glRenderbufferStorage, "glRenderbufferStorage"
    RemapVBFunctionToGLFunction AddressOf glIsRenderbuffer, "glIsRenderbuffer"
    RemapVBFunctionToGLFunction AddressOf glIsFramebuffer, "glIsFramebuffer"
    RemapVBFunctionToGLFunction AddressOf glGetRenderbufferParameteriv, "glGetRenderbufferParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetFramebufferAttachmentParameteriv, "glGetFramebufferAttachmentParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGenerateMipmap, "glGenerateMipmap"
    RemapVBFunctionToGLFunction AddressOf glGenRenderbuffers, "glGenRenderbuffers"
    RemapVBFunctionToGLFunction AddressOf glGenFramebuffers, "glGenFramebuffers"
    RemapVBFunctionToGLFunction AddressOf glFramebufferTextureLayer, "glFramebufferTextureLayer"
    RemapVBFunctionToGLFunction AddressOf glFramebufferTexture3D, "glFramebufferTexture3D"
    RemapVBFunctionToGLFunction AddressOf glFramebufferTexture2D, "glFramebufferTexture2D"
    RemapVBFunctionToGLFunction AddressOf glFramebufferTexture1D, "glFramebufferTexture1D"
    RemapVBFunctionToGLFunction AddressOf glFramebufferRenderbuffer, "glFramebufferRenderbuffer"
    RemapVBFunctionToGLFunction AddressOf glDeleteRenderbuffers, "glDeleteRenderbuffers"
    RemapVBFunctionToGLFunction AddressOf glDeleteFramebuffers, "glDeleteFramebuffers"
    RemapVBFunctionToGLFunction AddressOf glCheckFramebufferStatus, "glCheckFramebufferStatus"
    RemapVBFunctionToGLFunction AddressOf glBlitFramebuffer, "glBlitFramebuffer"
    RemapVBFunctionToGLFunction AddressOf glBindRenderbuffer, "glBindRenderbuffer"
    RemapVBFunctionToGLFunction AddressOf glBindFramebuffer, "glBindFramebuffer"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferParameteriEXT, "glNamedFramebufferParameteriEXT"
    RemapVBFunctionToGLFunction AddressOf glGetNamedFramebufferParameterivEXT, "glGetNamedFramebufferParameterivEXT"
    RemapVBFunctionToGLFunction AddressOf glGetFramebufferParameteriv, "glGetFramebufferParameteriv"
    RemapVBFunctionToGLFunction AddressOf glFramebufferParameteri, "glFramebufferParameteri"
    RemapVBFunctionToGLFunction AddressOf glDrawElementsIndirect, "glDrawElementsIndirect"
    RemapVBFunctionToGLFunction AddressOf glDrawArraysIndirect, "glDrawArraysIndirect"
    RemapVBFunctionToGLFunction AddressOf glMultiDrawElementsBaseVertex, "glMultiDrawElementsBaseVertex"
    RemapVBFunctionToGLFunction AddressOf glDrawRangeElementsBaseVertex, "glDrawRangeElementsBaseVertex"
    RemapVBFunctionToGLFunction AddressOf glDrawElementsInstancedBaseVertex, "glDrawElementsInstancedBaseVertex"
    RemapVBFunctionToGLFunction AddressOf glDrawElementsBaseVertex, "glDrawElementsBaseVertex"
    RemapVBFunctionToGLFunction AddressOf glBlendFunciARB, "glBlendFunciARB"
    RemapVBFunctionToGLFunction AddressOf glBlendFuncSeparateiARB, "glBlendFuncSeparateiARB"
    RemapVBFunctionToGLFunction AddressOf glBlendEquationiARB, "glBlendEquationiARB"
    RemapVBFunctionToGLFunction AddressOf glBlendEquationSeparateiARB, "glBlendEquationSeparateiARB"
    RemapVBFunctionToGLFunction AddressOf glDrawBuffersARB, "glDrawBuffersARB"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayVertexBuffers, "glVertexArrayVertexBuffers"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayVertexBuffer, "glVertexArrayVertexBuffer"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayElementBuffer, "glVertexArrayElementBuffer"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayBindingDivisor, "glVertexArrayBindingDivisor"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayAttribLFormat, "glVertexArrayAttribLFormat"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayAttribIFormat, "glVertexArrayAttribIFormat"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayAttribFormat, "glVertexArrayAttribFormat"
    RemapVBFunctionToGLFunction AddressOf glVertexArrayAttribBinding, "glVertexArrayAttribBinding"
    RemapVBFunctionToGLFunction AddressOf glUnmapNamedBuffer, "glUnmapNamedBuffer"
    RemapVBFunctionToGLFunction AddressOf glTransformFeedbackBufferRange, "glTransformFeedbackBufferRange"
    RemapVBFunctionToGLFunction AddressOf glTransformFeedbackBufferBase, "glTransformFeedbackBufferBase"
    RemapVBFunctionToGLFunction AddressOf glTextureSubImage3D, "glTextureSubImage3D"
    RemapVBFunctionToGLFunction AddressOf glTextureSubImage2D, "glTextureSubImage2D"
    RemapVBFunctionToGLFunction AddressOf glTextureSubImage1D, "glTextureSubImage1D"
    RemapVBFunctionToGLFunction AddressOf glTextureStorage3DMultisample, "glTextureStorage3DMultisample"
    RemapVBFunctionToGLFunction AddressOf glTextureStorage3D, "glTextureStorage3D"
    RemapVBFunctionToGLFunction AddressOf glTextureStorage2DMultisample, "glTextureStorage2DMultisample"
    RemapVBFunctionToGLFunction AddressOf glTextureStorage2D, "glTextureStorage2D"
    RemapVBFunctionToGLFunction AddressOf glTextureStorage1D, "glTextureStorage1D"
    RemapVBFunctionToGLFunction AddressOf glTextureParameteriv, "glTextureParameteriv"
    RemapVBFunctionToGLFunction AddressOf glTextureParameteri, "glTextureParameteri"
    RemapVBFunctionToGLFunction AddressOf glTextureParameterfv, "glTextureParameterfv"
    RemapVBFunctionToGLFunction AddressOf glTextureParameterf, "glTextureParameterf"
    RemapVBFunctionToGLFunction AddressOf glTextureParameterIuiv, "glTextureParameterIuiv"
    RemapVBFunctionToGLFunction AddressOf glTextureParameterIiv, "glTextureParameterIiv"
    RemapVBFunctionToGLFunction AddressOf glTextureBufferRange, "glTextureBufferRange"
    RemapVBFunctionToGLFunction AddressOf glTextureBuffer, "glTextureBuffer"
    RemapVBFunctionToGLFunction AddressOf glNamedRenderbufferStorageMultisample, "glNamedRenderbufferStorageMultisample"
    RemapVBFunctionToGLFunction AddressOf glNamedRenderbufferStorage, "glNamedRenderbufferStorage"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferTextureLayer, "glNamedFramebufferTextureLayer"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferTexture, "glNamedFramebufferTexture"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferRenderbuffer, "glNamedFramebufferRenderbuffer"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferReadBuffer, "glNamedFramebufferReadBuffer"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferParameteri, "glNamedFramebufferParameteri"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferDrawBuffers, "glNamedFramebufferDrawBuffers"
    RemapVBFunctionToGLFunction AddressOf glNamedFramebufferDrawBuffer, "glNamedFramebufferDrawBuffer"
    RemapVBFunctionToGLFunction AddressOf glNamedBufferSubData, "glNamedBufferSubData"
    RemapVBFunctionToGLFunction AddressOf glNamedBufferStorage, "glNamedBufferStorage"
    RemapVBFunctionToGLFunction AddressOf glNamedBufferData, "glNamedBufferData"
    RemapVBFunctionToGLFunction AddressOf glInvalidateNamedFramebufferSubData, "glInvalidateNamedFramebufferSubData"
    RemapVBFunctionToGLFunction AddressOf glInvalidateNamedFramebufferData, "glInvalidateNamedFramebufferData"
    RemapVBFunctionToGLFunction AddressOf glGetVertexArrayiv, "glGetVertexArrayiv"
    RemapVBFunctionToGLFunction AddressOf glGetVertexArrayIndexediv, "glGetVertexArrayIndexediv"
    RemapVBFunctionToGLFunction AddressOf glGetVertexArrayIndexed64iv, "glGetVertexArrayIndexed64iv"
    RemapVBFunctionToGLFunction AddressOf glGetTransformFeedbackiv, "glGetTransformFeedbackiv"
    RemapVBFunctionToGLFunction AddressOf glGetTransformFeedbacki_v, "glGetTransformFeedbacki_v"
    RemapVBFunctionToGLFunction AddressOf glGetTransformFeedbacki64_v, "glGetTransformFeedbacki64_v"
    RemapVBFunctionToGLFunction AddressOf glGetTextureParameteriv, "glGetTextureParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetTextureParameterfv, "glGetTextureParameterfv"
    RemapVBFunctionToGLFunction AddressOf glGetTextureParameterIuiv, "glGetTextureParameterIuiv"
    RemapVBFunctionToGLFunction AddressOf glGetTextureParameterIiv, "glGetTextureParameterIiv"
    RemapVBFunctionToGLFunction AddressOf glGetTextureLevelParameteriv, "glGetTextureLevelParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetTextureLevelParameterfv, "glGetTextureLevelParameterfv"
    RemapVBFunctionToGLFunction AddressOf glGetTextureImage, "glGetTextureImage"
    RemapVBFunctionToGLFunction AddressOf glGetQueryBufferObjectuiv, "glGetQueryBufferObjectuiv"
    RemapVBFunctionToGLFunction AddressOf glGetQueryBufferObjectui64v, "glGetQueryBufferObjectui64v"
    RemapVBFunctionToGLFunction AddressOf glGetQueryBufferObjectiv, "glGetQueryBufferObjectiv"
    RemapVBFunctionToGLFunction AddressOf glGetQueryBufferObjecti64v, "glGetQueryBufferObjecti64v"
    RemapVBFunctionToGLFunction AddressOf glGetNamedRenderbufferParameteriv, "glGetNamedRenderbufferParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetNamedFramebufferParameteriv, "glGetNamedFramebufferParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetNamedFramebufferAttachmentParameteriv, "glGetNamedFramebufferAttachmentParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetNamedBufferSubData, "glGetNamedBufferSubData"
    RemapVBFunctionToGLFunction AddressOf glGetNamedBufferPointerv, "glGetNamedBufferPointerv"
    RemapVBFunctionToGLFunction AddressOf glGetNamedBufferParameteriv, "glGetNamedBufferParameteriv"
    RemapVBFunctionToGLFunction AddressOf glGetNamedBufferParameteri64v, "glGetNamedBufferParameteri64v"
    RemapVBFunctionToGLFunction AddressOf glGetCompressedTextureImage, "glGetCompressedTextureImage"
    RemapVBFunctionToGLFunction AddressOf glGenerateTextureMipmap, "glGenerateTextureMipmap"
    RemapVBFunctionToGLFunction AddressOf glFlushMappedNamedBufferRange, "glFlushMappedNamedBufferRange"
    RemapVBFunctionToGLFunction AddressOf glEnableVertexArrayAttrib, "glEnableVertexArrayAttrib"
    RemapVBFunctionToGLFunction AddressOf glDisableVertexArrayAttrib, "glDisableVertexArrayAttrib"
    RemapVBFunctionToGLFunction AddressOf glCreateVertexArrays, "glCreateVertexArrays"
    RemapVBFunctionToGLFunction AddressOf glCreateTransformFeedbacks, "glCreateTransformFeedbacks"
    RemapVBFunctionToGLFunction AddressOf glCreateTextures, "glCreateTextures"
    RemapVBFunctionToGLFunction AddressOf glCreateSamplers, "glCreateSamplers"
    RemapVBFunctionToGLFunction AddressOf glCreateRenderbuffers, "glCreateRenderbuffers"
    RemapVBFunctionToGLFunction AddressOf glCreateQueries, "glCreateQueries"
    RemapVBFunctionToGLFunction AddressOf glCreateProgramPipelines, "glCreateProgramPipelines"
    RemapVBFunctionToGLFunction AddressOf glCreateFramebuffers, "glCreateFramebuffers"
    RemapVBFunctionToGLFunction AddressOf glCreateBuffers, "glCreateBuffers"
    RemapVBFunctionToGLFunction AddressOf glCopyTextureSubImage3D, "glCopyTextureSubImage3D"
    RemapVBFunctionToGLFunction AddressOf glCopyTextureSubImage2D, "glCopyTextureSubImage2D"
    RemapVBFunctionToGLFunction AddressOf glCopyTextureSubImage1D, "glCopyTextureSubImage1D"
    RemapVBFunctionToGLFunction AddressOf glCopyNamedBufferSubData, "glCopyNamedBufferSubData"
    RemapVBFunctionToGLFunction AddressOf glCompressedTextureSubImage3D, "glCompressedTextureSubImage3D"
    RemapVBFunctionToGLFunction AddressOf glCompressedTextureSubImage2D, "glCompressedTextureSubImage2D"
    RemapVBFunctionToGLFunction AddressOf glCompressedTextureSubImage1D, "glCompressedTextureSubImage1D"
    RemapVBFunctionToGLFunction AddressOf glClearNamedFramebufferuiv, "glClearNamedFramebufferuiv"
    RemapVBFunctionToGLFunction AddressOf glClearNamedFramebufferiv, "glClearNamedFramebufferiv"
    RemapVBFunctionToGLFunction AddressOf glClearNamedFramebufferfv, "glClearNamedFramebufferfv"
    RemapVBFunctionToGLFunction AddressOf glClearNamedFramebufferfi, "glClearNamedFramebufferfi"
    RemapVBFunctionToGLFunction AddressOf glClearNamedBufferSubData, "glClearNamedBufferSubData"
    RemapVBFunctionToGLFunction AddressOf glClearNamedBufferData, "glClearNamedBufferData"
    RemapVBFunctionToGLFunction AddressOf glCheckNamedFramebufferStatus, "glCheckNamedFramebufferStatus"
    RemapVBFunctionToGLFunction AddressOf glBlitNamedFramebuffer, "glBlitNamedFramebuffer"
    RemapVBFunctionToGLFunction AddressOf glBindTextureUnit, "glBindTextureUnit"
    RemapVBFunctionToGLFunction AddressOf glGetDebugMessageLogARB, "glGetDebugMessageLogARB"
    RemapVBFunctionToGLFunction AddressOf glDebugMessageInsertARB, "glDebugMessageInsertARB"
    RemapVBFunctionToGLFunction AddressOf glDebugMessageControlARB, "glDebugMessageControlARB"
    RemapVBFunctionToGLFunction AddressOf glDebugMessageCallbackARB, "glDebugMessageCallbackARB"
    RemapVBFunctionToGLFunction AddressOf glCopyImageSubData, "glCopyImageSubData"
    RemapVBFunctionToGLFunction AddressOf glCopyBufferSubData, "glCopyBufferSubData"
    RemapVBFunctionToGLFunction AddressOf glDispatchComputeGroupSizeARB, "glDispatchComputeGroupSizeARB"
    RemapVBFunctionToGLFunction AddressOf glDispatchComputeIndirect, "glDispatchComputeIndirect"
    RemapVBFunctionToGLFunction AddressOf glDispatchCompute, "glDispatchCompute"
    RemapVBFunctionToGLFunction AddressOf glClampColorARB, "glClampColorARB"
    RemapVBFunctionToGLFunction AddressOf glClipControl, "glClipControl"
    RemapVBFunctionToGLFunction AddressOf glClearTexSubImage, "glClearTexSubImage"
    RemapVBFunctionToGLFunction AddressOf glClearTexImage, "glClearTexImage"
    RemapVBFunctionToGLFunction AddressOf glClearNamedBufferSubDataEXT, "glClearNamedBufferSubDataEXT"
    RemapVBFunctionToGLFunction AddressOf glClearNamedBufferDataEXT, "glClearNamedBufferDataEXT"
    RemapVBFunctionToGLFunction AddressOf glClearBufferSubData, "glClearBufferSubData"
    RemapVBFunctionToGLFunction AddressOf glClearBufferData, "glClearBufferData"
    RemapVBFunctionToGLFunction AddressOf glCreateSyncFromCLeventARB, "glCreateSyncFromCLeventARB"
    RemapVBFunctionToGLFunction AddressOf glBufferStorage, "glBufferStorage"
    RemapVBFunctionToGLFunction AddressOf glGetFragDataIndex, "glGetFragDataIndex"
    RemapVBFunctionToGLFunction AddressOf glBindFragDataLocationIndexed, "glBindFragDataLocationIndexed"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL1ui64vARB, "glVertexAttribL1ui64vARB"
    RemapVBFunctionToGLFunction AddressOf glVertexAttribL1ui64ARB, "glVertexAttribL1ui64ARB"
    RemapVBFunctionToGLFunction AddressOf glUniformHandleui64vARB, "glUniformHandleui64vARB"
    RemapVBFunctionToGLFunction AddressOf glUniformHandleui64ARB, "glUniformHandleui64ARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformHandleui64vARB, "glProgramUniformHandleui64vARB"
    RemapVBFunctionToGLFunction AddressOf glProgramUniformHandleui64ARB, "glProgramUniformHandleui64ARB"
    RemapVBFunctionToGLFunction AddressOf glMakeTextureHandleResidentARB, "glMakeTextureHandleResidentARB"
    RemapVBFunctionToGLFunction AddressOf glMakeTextureHandleNonResidentARB, "glMakeTextureHandleNonResidentARB"
    RemapVBFunctionToGLFunction AddressOf glMakeImageHandleResidentARB, "glMakeImageHandleResidentARB"
    RemapVBFunctionToGLFunction AddressOf glMakeImageHandleNonResidentARB, "glMakeImageHandleNonResidentARB"
    RemapVBFunctionToGLFunction AddressOf glIsTextureHandleResidentARB, "glIsTextureHandleResidentARB"
    RemapVBFunctionToGLFunction AddressOf glIsImageHandleResidentARB, "glIsImageHandleResidentARB"
    RemapVBFunctionToGLFunction AddressOf glGetVertexAttribLui64vARB, "glGetVertexAttribLui64vARB"
    RemapVBFunctionToGLFunction AddressOf glGetTextureSamplerHandleARB, "glGetTextureSamplerHandleARB"
    RemapVBFunctionToGLFunction AddressOf glGetTextureHandleARB, "glGetTextureHandleARB"
    RemapVBFunctionToGLFunction AddressOf glGetImageHandleARB, "glGetImageHandleARB"
    RemapVBFunctionToGLFunction AddressOf glDrawElementsInstancedBaseVertexBaseInstance, "glDrawElementsInstancedBaseVertexBaseInstance"
    RemapVBFunctionToGLFunction AddressOf glDrawElementsInstancedBaseInstance, "glDrawElementsInstancedBaseInstance"
    RemapVBFunctionToGLFunction AddressOf glDrawArraysInstancedBaseInstance, "glDrawArraysInstancedBaseInstance"
    RemapVBFunctionToGLFunction AddressOf glPrimitiveBoundingBoxARB, "glPrimitiveBoundingBoxARB"
    RemapVBFunctionToGLFunction AddressOf glMemoryBarrierByRegion, "glMemoryBarrierByRegion"
    RemapVBFunctionToGLFunction AddressOf glShaderBinary, "glShaderBinary"
    RemapVBFunctionToGLFunction AddressOf glReleaseShaderCompiler, "glReleaseShaderCompiler"
    RemapVBFunctionToGLFunction AddressOf glGetShaderPrecisionFormat, "glGetShaderPrecisionFormat"
    RemapVBFunctionToGLFunction AddressOf glDepthRangef, "glDepthRangef"
    RemapVBFunctionToGLFunction AddressOf glClearDepthf, "glClearDepthf"
End If
End Function
