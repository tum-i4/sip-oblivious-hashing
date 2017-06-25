; ModuleID = 'asserts.bc'
source_filename = "asserts.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%class.logger = type { %"class.std::__1::basic_ofstream" }
%"class.std::__1::basic_ofstream" = type { %"class.std::__1::basic_ostream.base", %"class.std::__1::basic_filebuf", %"class.std::__1::basic_ios.base" }
%"class.std::__1::basic_ostream.base" = type { i32 (...)** }
%"class.std::__1::basic_filebuf" = type <{ %"class.std::__1::basic_streambuf", i8*, i8*, i8*, [8 x i8], i64, i8*, i64, %struct._IO_FILE*, %"class.std::__1::codecvt"*, %struct.__mbstate_t, %struct.__mbstate_t, i32, i32, i8, i8, i8, [5 x i8] }>
%"class.std::__1::basic_streambuf" = type { i32 (...)**, %"class.std::__1::locale", i8*, i8*, i8*, i8*, i8*, i8* }
%"class.std::__1::locale" = type { %"class.std::__1::locale::__imp"* }
%"class.std::__1::locale::__imp" = type opaque
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%"class.std::__1::codecvt" = type { %"class.std::__1::locale::facet" }
%"class.std::__1::locale::facet" = type { %"class.std::__1::__shared_count" }
%"class.std::__1::__shared_count" = type { i32 (...)**, i64 }
%struct.__mbstate_t = type { i32, %union.anon }
%union.anon = type { i32 }
%"class.std::__1::basic_ios.base" = type <{ %"class.std::__1::ios_base", %"class.std::__1::basic_ostream"*, i32 }>
%"class.std::__1::ios_base" = type { i32 (...)**, i32, i64, i64, i32, i32, i8*, i8*, void (i32, %"class.std::__1::ios_base"*, i32)**, i32*, i64, i64, i64*, i64, i64, i8**, i64, i64 }
%"class.std::__1::basic_ostream" = type { i32 (...)**, %"class.std::__1::basic_ios.base" }
%"class.std::__1::locale::id" = type <{ %"struct.std::__1::once_flag", i32, [4 x i8] }>
%"struct.std::__1::once_flag" = type { i64 }
%"class.std::__1::basic_ios" = type <{ %"class.std::__1::ios_base", %"class.std::__1::basic_ostream"*, i32, [4 x i8] }>
%"struct.std::__1::__less" = type { i8 }
%"class.std::__1::fpos" = type { %struct.__mbstate_t, i64 }
%"class.std::bad_cast" = type { %"class.std::exception" }
%"class.std::exception" = type { i32 (...)** }
%"struct.std::__1::__less.0" = type { i8 }
%"class.std::__1::__libcpp_compressed_pair_imp" = type { %struct._IO_FILE*, i32 (%struct._IO_FILE*)* }
%"class.std::__1::__compressed_pair" = type { %"class.std::__1::__libcpp_compressed_pair_imp" }
%"class.std::__1::unique_ptr" = type { %"class.std::__1::__compressed_pair" }
%"class.std::__1::ctype" = type <{ %"class.std::__1::locale::facet", i16*, i8, [7 x i8] }>
%"class.std::__1::ostreambuf_iterator" = type { %"class.std::__1::basic_streambuf"* }
%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry" = type { i8, %"class.std::__1::basic_ostream"* }
%"struct.std::__1::iterator" = type { i8 }
%"class.std::__1::__libcpp_compressed_pair_imp.2" = type { %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep" }
%"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep" = type { %union.anon.3 }
%union.anon.3 = type { %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long" }
%"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long" = type { i64, i64, i8* }
%"class.std::__1::__compressed_pair.1" = type { %"class.std::__1::__libcpp_compressed_pair_imp.2" }
%"class.std::__1::basic_string" = type { %"class.std::__1::__compressed_pair.1" }
%"class.std::__1::allocator" = type { i8 }
%"struct.std::__1::integral_constant" = type { i8 }
%"struct.std::__1::__has_max_size" = type { i8 }
%"class.std::__1::__basic_string_common" = type { i8 }
%"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short" = type { %union.anon.4, [23 x i8] }
%union.anon.4 = type { i8 }
%"class.std::length_error" = type { %"class.std::logic_error" }
%"class.std::logic_error" = type { %"class.std::exception", %"class.std::__1::__libcpp_refstring" }
%"class.std::__1::__libcpp_refstring" = type { i8* }

$_ZN6loggerC2Ev = comdat any

$_ZN6loggerD2Ev = comdat any

$_ZN6logger6finishEv = comdat any

$_ZN6logger3logEmmm = comdat any

$_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEE4openEPKcj = comdat any

$_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev = comdat any

$_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED0Ev = comdat any

$_ZTv0_n24_NSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev = comdat any

$_ZTv0_n24_NSt3__114basic_ofstreamIcNS_11char_traitsIcEEED0Ev = comdat any

$_ZNSt3__111char_traitsIcE3eofEv = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi = comdat any

$__clang_call_terminate = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5closeEv = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE11__read_modeEv = comdat any

$_ZNSt3__111char_traitsIcE11to_int_typeEc = comdat any

$_ZNSt3__111char_traitsIcE11eq_int_typeEii = comdat any

$_ZNSt3__111char_traitsIcE7not_eofEi = comdat any

$_ZNSt3__111char_traitsIcE2eqEcc = comdat any

$_ZNSt3__111char_traitsIcE12to_char_typeEi = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE12__write_modeEv = comdat any

$_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4openEPKcj = comdat any

$_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED2Ev = comdat any

$_ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc = comdat any

$_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m = comdat any

$_ZNSt3__111char_traitsIcE6lengthEPKc = comdat any

$_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_ = comdat any

$_ZNSt3__111char_traitsIcE6assignEPcmc = comdat any

$_ZNSt3__111char_traitsIcE6assignERcRKc = comdat any

$_ZTVNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE = comdat any

$_ZTTNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE = comdat any

$_ZTCNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE0_NS_13basic_ostreamIcS2_EE = comdat any

$_ZTSNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE = comdat any

$_ZTINSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE = comdat any

$_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE = comdat any

$_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE = comdat any

$_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE = comdat any

@_ZZ3logE7_logger = internal global %class.logger zeroinitializer, align 8
@_ZGVZ3logE7_logger = internal global i64 0, align 8
@__dso_handle = external global i8
@.str = private unnamed_addr constant [11 x i8] c"hashes.log\00", align 1
@_ZTVNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE = linkonce_odr unnamed_addr constant [10 x i8*] [i8* inttoptr (i64 176 to i8*), i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTINSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE to i8*), i8* bitcast (void (%"class.std::__1::basic_ofstream"*)* @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev to i8*), i8* bitcast (void (%"class.std::__1::basic_ofstream"*)* @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED0Ev to i8*), i8* inttoptr (i64 -176 to i8*), i8* inttoptr (i64 -176 to i8*), i8* bitcast ({ i8*, i8*, i8* }* @_ZTINSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE to i8*), i8* bitcast (void (%"class.std::__1::basic_ofstream"*)* @_ZTv0_n24_NSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev to i8*), i8* bitcast (void (%"class.std::__1::basic_ofstream"*)* @_ZTv0_n24_NSt3__114basic_ofstreamIcNS_11char_traitsIcEEED0Ev to i8*)], comdat, align 8
@_ZTTNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE = linkonce_odr unnamed_addr constant [4 x i8*] [i8* bitcast (i8** getelementptr inbounds ([10 x i8*], [10 x i8*]* @_ZTVNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i32 0, i32 3) to i8*), i8* bitcast (i8** getelementptr inbounds ([10 x i8*], [10 x i8*]* @_ZTCNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE0_NS_13basic_ostreamIcS2_EE, i32 0, i32 3) to i8*), i8* bitcast (i8** getelementptr inbounds ([10 x i8*], [10 x i8*]* @_ZTCNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE0_NS_13basic_ostreamIcS2_EE, i32 0, i32 8) to i8*), i8* bitcast (i8** getelementptr inbounds ([10 x i8*], [10 x i8*]* @_ZTVNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i32 0, i32 8) to i8*)], comdat
@_ZTCNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE0_NS_13basic_ostreamIcS2_EE = linkonce_odr unnamed_addr constant [10 x i8*] [i8* inttoptr (i64 176 to i8*), i8* null, i8* bitcast (i8** @_ZTINSt3__113basic_ostreamIcNS_11char_traitsIcEEEE to i8*), i8* bitcast (void (%"class.std::__1::basic_ostream"*)* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEED1Ev to i8*), i8* bitcast (void (%"class.std::__1::basic_ostream"*)* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEED0Ev to i8*), i8* inttoptr (i64 -176 to i8*), i8* inttoptr (i64 -176 to i8*), i8* bitcast (i8** @_ZTINSt3__113basic_ostreamIcNS_11char_traitsIcEEEE to i8*), i8* bitcast (void (%"class.std::__1::basic_ostream"*)* @_ZTv0_n24_NSt3__113basic_ostreamIcNS_11char_traitsIcEEED1Ev to i8*), i8* bitcast (void (%"class.std::__1::basic_ostream"*)* @_ZTv0_n24_NSt3__113basic_ostreamIcNS_11char_traitsIcEEED0Ev to i8*)], comdat
@_ZTINSt3__113basic_ostreamIcNS_11char_traitsIcEEEE = external constant i8*
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
@_ZTSNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE = linkonce_odr constant [48 x i8] c"NSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE\00", comdat
@_ZTINSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE = linkonce_odr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([48 x i8], [48 x i8]* @_ZTSNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i32 0, i32 0), i8* bitcast (i8** @_ZTINSt3__113basic_ostreamIcNS_11char_traitsIcEEEE to i8*) }, comdat
@_ZTVNSt3__19basic_iosIcNS_11char_traitsIcEEEE = external unnamed_addr constant [4 x i8*]
@_ZTVNSt3__18ios_baseE = external unnamed_addr constant [4 x i8*]
@_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE = linkonce_odr unnamed_addr constant [16 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE to i8*), i8* bitcast (void (%"class.std::__1::basic_filebuf"*)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev to i8*), i8* bitcast (void (%"class.std::__1::basic_filebuf"*)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev to i8*), i8* bitcast (void (%"class.std::__1::basic_filebuf"*, %"class.std::__1::locale"*)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE to i8*), i8* bitcast (%"class.std::__1::basic_streambuf"* (%"class.std::__1::basic_filebuf"*, i8*, i64)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl to i8*), i8* bitcast ({ i64, i64 } (%"class.std::__1::basic_filebuf"*, i64, i32, i32)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj to i8*), i8* bitcast ({ i64, i64 } (%"class.std::__1::basic_filebuf"*, i64, i64, i32)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj to i8*), i8* bitcast (i32 (%"class.std::__1::basic_filebuf"*)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv to i8*), i8* bitcast (i64 (%"class.std::__1::basic_streambuf"*)* @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE9showmanycEv to i8*), i8* bitcast (i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)* @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE6xsgetnEPcl to i8*), i8* bitcast (i32 (%"class.std::__1::basic_filebuf"*)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv to i8*), i8* bitcast (i32 (%"class.std::__1::basic_streambuf"*)* @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5uflowEv to i8*), i8* bitcast (i32 (%"class.std::__1::basic_filebuf"*, i32)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi to i8*), i8* bitcast (i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)* @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE6xsputnEPKcl to i8*), i8* bitcast (i32 (%"class.std::__1::basic_filebuf"*, i32)* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi to i8*)], comdat, align 8
@_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE = linkonce_odr constant [47 x i8] c"NSt3__113basic_filebufIcNS_11char_traitsIcEEEE\00", comdat
@_ZTINSt3__115basic_streambufIcNS_11char_traitsIcEEEE = external constant i8*
@_ZTINSt3__113basic_filebufIcNS_11char_traitsIcEEEE = linkonce_odr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8*, i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([47 x i8], [47 x i8]* @_ZTSNSt3__113basic_filebufIcNS_11char_traitsIcEEEE, i32 0, i32 0), i8* bitcast (i8** @_ZTINSt3__115basic_streambufIcNS_11char_traitsIcEEEE to i8*) }, comdat
@_ZNSt3__17codecvtIcc11__mbstate_tE2idE = external global %"class.std::__1::locale::id", align 8
@_ZTISt8bad_cast = external constant i8*
@.str.1 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.3 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"r+\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"w+\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"a+\00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"wb\00", align 1
@.str.8 = private unnamed_addr constant [3 x i8] c"ab\00", align 1
@.str.9 = private unnamed_addr constant [3 x i8] c"rb\00", align 1
@.str.10 = private unnamed_addr constant [4 x i8] c"r+b\00", align 1
@.str.11 = private unnamed_addr constant [4 x i8] c"w+b\00", align 1
@.str.12 = private unnamed_addr constant [4 x i8] c"a+b\00", align 1
@.str.13 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.14 = private unnamed_addr constant [68 x i8] c"allocator<T>::allocate(size_t n) 'n' exceeds maximum supported size\00", align 1
@_ZTISt12length_error = external constant i8*
@_ZTVSt12length_error = external unnamed_addr constant [5 x i8*]
@_ZNSt3__15ctypeIcE2idE = external global %"class.std::__1::locale::id", align 8

; Function Attrs: uwtable
define void @log(i64 %line_num, i64 %column_num, i64* %hashVar) #0 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %line_num.addr = alloca i64, align 8
  %column_num.addr = alloca i64, align 8
  %hashVar.addr = alloca i64*, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store i64 %line_num, i64* %line_num.addr, align 8
  store i64 %column_num, i64* %column_num.addr, align 8
  store i64* %hashVar, i64** %hashVar.addr, align 8
  %0 = load atomic i8, i8* bitcast (i64* @_ZGVZ3logE7_logger to i8*) acquire, align 8
  %guard.uninitialized = icmp eq i8 %0, 0
  br i1 %guard.uninitialized, label %init.check, label %init.end

init.check:                                       ; preds = %entry
  %1 = call i32 @__cxa_guard_acquire(i64* @_ZGVZ3logE7_logger) #1
  %tobool = icmp ne i32 %1, 0
  br i1 %tobool, label %init, label %init.end

init:                                             ; preds = %init.check
  invoke void @_ZN6loggerC2Ev(%class.logger* @_ZZ3logE7_logger)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %init
  %2 = call i32 @__cxa_atexit(void (i8*)* bitcast (void (%class.logger*)* @_ZN6loggerD2Ev to void (i8*)*), i8* bitcast (%class.logger* @_ZZ3logE7_logger to i8*), i8* @__dso_handle) #1
  call void @__cxa_guard_release(i64* @_ZGVZ3logE7_logger) #1
  br label %init.end

init.end:                                         ; preds = %invoke.cont, %init.check, %entry
  %3 = load i64, i64* %line_num.addr, align 8
  %cmp = icmp eq i64 %3, 0
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %init.end
  %4 = load i64, i64* %column_num.addr, align 8
  %cmp1 = icmp eq i64 %4, 0
  br i1 %cmp1, label %if.then, label %lor.lhs.false2

lor.lhs.false2:                                   ; preds = %lor.lhs.false
  %5 = load i64*, i64** %hashVar.addr, align 8
  %cmp3 = icmp eq i64* %5, null
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false2, %lor.lhs.false, %init.end
  call void @_ZN6logger6finishEv(%class.logger* @_ZZ3logE7_logger)
  br label %if.end

lpad:                                             ; preds = %init
  %6 = landingpad { i8*, i32 }
          cleanup
  %7 = extractvalue { i8*, i32 } %6, 0
  store i8* %7, i8** %exn.slot, align 8
  %8 = extractvalue { i8*, i32 } %6, 1
  store i32 %8, i32* %ehselector.slot, align 4
  call void @__cxa_guard_abort(i64* @_ZGVZ3logE7_logger) #1
  br label %eh.resume

if.end:                                           ; preds = %if.then, %lor.lhs.false2
  %9 = load i64, i64* %line_num.addr, align 8
  %10 = load i64, i64* %column_num.addr, align 8
  %11 = load i64*, i64** %hashVar.addr, align 8
  %12 = load i64, i64* %11, align 8
  call void @_ZN6logger3logEmmm(%class.logger* @_ZZ3logE7_logger, i64 %9, i64 %10, i64 %12)
  ret void

eh.resume:                                        ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val4 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val4
}

; Function Attrs: nounwind
declare i32 @__cxa_guard_acquire(i64*) #1

; Function Attrs: uwtable
define linkonce_odr void @_ZN6loggerC2Ev(%class.logger* %this) unnamed_addr #0 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr.i.i7.i = alloca %"class.std::__1::basic_ios"*, align 8
  %__sb.addr.i.i.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i8.i = alloca %"class.std::__1::basic_ostream"*, align 8
  %vtt.addr.i.i = alloca i8**, align 8
  %__sb.addr.i.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i.i.i = alloca %"class.std::__1::ios_base"*, align 8
  %this.addr.i.i = alloca %"class.std::__1::basic_ios"*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_ofstream"*, align 8
  %exn.slot.i = alloca i8*
  %ehselector.slot.i = alloca i32
  %this.addr = alloca %class.logger*, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %class.logger* %this, %class.logger** %this.addr, align 8
  %this1 = load %class.logger*, %class.logger** %this.addr, align 8
  %log_stream = getelementptr inbounds %class.logger, %class.logger* %this1, i32 0, i32 0
  store %"class.std::__1::basic_ofstream"* %log_stream, %"class.std::__1::basic_ofstream"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_ofstream"*, %"class.std::__1::basic_ofstream"** %this.addr.i, align 8
  %0 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to i8*
  %1 = getelementptr inbounds i8, i8* %0, i64 176
  %2 = bitcast i8* %1 to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %2, %"class.std::__1::basic_ios"** %this.addr.i.i, align 8
  %this1.i.i = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i.i, align 8
  %3 = bitcast %"class.std::__1::basic_ios"* %this1.i.i to %"class.std::__1::ios_base"*
  store %"class.std::__1::ios_base"* %3, %"class.std::__1::ios_base"** %this.addr.i.i.i, align 8
  %this1.i.i.i = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %this.addr.i.i.i, align 8
  %4 = bitcast %"class.std::__1::ios_base"* %this1.i.i.i to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*], [4 x i8*]* @_ZTVNSt3__18ios_baseE, i32 0, i32 2) to i32 (...)**), i32 (...)*** %4, align 8
  %5 = bitcast %"class.std::__1::basic_ios"* %this1.i.i to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*], [4 x i8*]* @_ZTVNSt3__19basic_iosIcNS_11char_traitsIcEEEE, i32 0, i32 2) to i32 (...)**), i32 (...)*** %5, align 8
  %6 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([10 x i8*], [10 x i8*]* @_ZTVNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i32 0, i32 3) to i32 (...)**), i32 (...)*** %6, align 8
  %7 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to i8*
  %add.ptr.i = getelementptr inbounds i8, i8* %7, i64 176
  %8 = bitcast i8* %add.ptr.i to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([10 x i8*], [10 x i8*]* @_ZTVNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i32 0, i32 8) to i32 (...)**), i32 (...)*** %8, align 8
  %9 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to %"class.std::__1::basic_ostream"*
  %__sb_.i = getelementptr inbounds %"class.std::__1::basic_ofstream", %"class.std::__1::basic_ofstream"* %this1.i, i32 0, i32 1
  %10 = bitcast %"class.std::__1::basic_filebuf"* %__sb_.i to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_ostream"* %9, %"class.std::__1::basic_ostream"** %this.addr.i8.i, align 8
  store i8** getelementptr inbounds ([4 x i8*], [4 x i8*]* @_ZTTNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i64 0, i64 1), i8*** %vtt.addr.i.i, align 8
  store %"class.std::__1::basic_streambuf"* %10, %"class.std::__1::basic_streambuf"** %__sb.addr.i.i, align 8
  %this1.i9.i = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %this.addr.i8.i, align 8
  %vtt2.i.i = load i8**, i8*** %vtt.addr.i.i, align 8
  %11 = load i8*, i8** %vtt2.i.i, align 8
  %12 = bitcast %"class.std::__1::basic_ostream"* %this1.i9.i to i32 (...)***
  %13 = bitcast i8* %11 to i32 (...)**
  store i32 (...)** %13, i32 (...)*** %12, align 8
  %14 = getelementptr inbounds i8*, i8** %vtt2.i.i, i64 1
  %15 = load i8*, i8** %14, align 8
  %16 = bitcast %"class.std::__1::basic_ostream"* %this1.i9.i to i8**
  %vtable.i.i = load i8*, i8** %16, align 8
  %vbase.offset.ptr.i.i = getelementptr i8, i8* %vtable.i.i, i64 -24
  %17 = bitcast i8* %vbase.offset.ptr.i.i to i64*
  %vbase.offset.i.i = load i64, i64* %17, align 8
  %18 = bitcast %"class.std::__1::basic_ostream"* %this1.i9.i to i8*
  %add.ptr.i.i = getelementptr inbounds i8, i8* %18, i64 %vbase.offset.i.i
  %19 = bitcast i8* %add.ptr.i.i to i32 (...)***
  %20 = bitcast i8* %15 to i32 (...)**
  store i32 (...)** %20, i32 (...)*** %19, align 8
  %21 = bitcast %"class.std::__1::basic_ostream"* %this1.i9.i to i8**
  %vtable3.i.i = load i8*, i8** %21, align 8
  %vbase.offset.ptr4.i.i = getelementptr i8, i8* %vtable3.i.i, i64 -24
  %22 = bitcast i8* %vbase.offset.ptr4.i.i to i64*
  %vbase.offset5.i.i = load i64, i64* %22, align 8
  %23 = bitcast %"class.std::__1::basic_ostream"* %this1.i9.i to i8*
  %add.ptr6.i.i = getelementptr inbounds i8, i8* %23, i64 %vbase.offset5.i.i
  %24 = bitcast i8* %add.ptr6.i.i to %"class.std::__1::basic_ios"*
  %25 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %__sb.addr.i.i, align 8
  store %"class.std::__1::basic_ios"* %24, %"class.std::__1::basic_ios"** %this.addr.i.i7.i, align 8
  store %"class.std::__1::basic_streambuf"* %25, %"class.std::__1::basic_streambuf"** %__sb.addr.i.i.i, align 8
  %this1.i.i10.i = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i.i7.i, align 8
  %26 = bitcast %"class.std::__1::basic_ios"* %this1.i.i10.i to %"class.std::__1::ios_base"*
  %27 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %__sb.addr.i.i.i, align 8
  %28 = bitcast %"class.std::__1::basic_streambuf"* %27 to i8*
  invoke void @_ZNSt3__18ios_base4initEPv(%"class.std::__1::ios_base"* %26, i8* %28)
          to label %_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEEC2EPNS_15basic_streambufIcS2_EE.exit.i unwind label %lpad.i

_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEEC2EPNS_15basic_streambufIcS2_EE.exit.i: ; preds = %entry
  %__tie_.i.i.i = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %this1.i.i10.i, i32 0, i32 1
  store %"class.std::__1::basic_ostream"* null, %"class.std::__1::basic_ostream"** %__tie_.i.i.i, align 8
  %call.i.i.i = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  %__fill_.i.i.i = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %this1.i.i10.i, i32 0, i32 2
  store i32 %call.i.i.i, i32* %__fill_.i.i.i, align 8
  %29 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([10 x i8*], [10 x i8*]* @_ZTVNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i32 0, i32 3) to i32 (...)**), i32 (...)*** %29, align 8
  %30 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to i8*
  %add.ptr2.i = getelementptr inbounds i8, i8* %30, i64 176
  %31 = bitcast i8* %add.ptr2.i to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([10 x i8*], [10 x i8*]* @_ZTVNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i32 0, i32 8) to i32 (...)**), i32 (...)*** %31, align 8
  %__sb_3.i = getelementptr inbounds %"class.std::__1::basic_ofstream", %"class.std::__1::basic_ofstream"* %this1.i, i32 0, i32 1
  invoke void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev(%"class.std::__1::basic_filebuf"* %__sb_3.i)
          to label %_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEC1Ev.exit unwind label %lpad4.i

lpad.i:                                           ; preds = %entry
  %32 = landingpad { i8*, i32 }
          cleanup
  %33 = extractvalue { i8*, i32 } %32, 0
  store i8* %33, i8** %exn.slot.i, align 8
  %34 = extractvalue { i8*, i32 } %32, 1
  store i32 %34, i32* %ehselector.slot.i, align 4
  br label %ehcleanup.i

lpad4.i:                                          ; preds = %_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEEC2EPNS_15basic_streambufIcS2_EE.exit.i
  %35 = landingpad { i8*, i32 }
          cleanup
  %36 = extractvalue { i8*, i32 } %35, 0
  store i8* %36, i8** %exn.slot.i, align 8
  %37 = extractvalue { i8*, i32 } %35, 1
  store i32 %37, i32* %ehselector.slot.i, align 4
  %38 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to %"class.std::__1::basic_ostream"*
  call void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_ostream"* %38, i8** getelementptr inbounds ([4 x i8*], [4 x i8*]* @_ZTTNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i64 0, i64 1)) #1
  br label %ehcleanup.i

ehcleanup.i:                                      ; preds = %lpad4.i, %lpad.i
  %39 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to i8*
  %40 = getelementptr inbounds i8, i8* %39, i64 176
  %41 = bitcast i8* %40 to %"class.std::__1::basic_ios"*
  call void @_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_ios"* %41) #1
  %exn.i = load i8*, i8** %exn.slot.i, align 8
  %sel.i = load i32, i32* %ehselector.slot.i, align 4
  %lpad.val.i = insertvalue { i8*, i32 } undef, i8* %exn.i, 0
  %lpad.val6.i = insertvalue { i8*, i32 } %lpad.val.i, i32 %sel.i, 1
  resume { i8*, i32 } %lpad.val6.i

_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEC1Ev.exit: ; preds = %_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEEC2EPNS_15basic_streambufIcS2_EE.exit.i
  %log_stream2 = getelementptr inbounds %class.logger, %class.logger* %this1, i32 0, i32 0
  invoke void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEE4openEPKcj(%"class.std::__1::basic_ofstream"* %log_stream2, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), i32 16)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEC1Ev.exit
  ret void

lpad:                                             ; preds = %_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEC1Ev.exit
  %42 = landingpad { i8*, i32 }
          cleanup
  %43 = extractvalue { i8*, i32 } %42, 0
  store i8* %43, i8** %exn.slot, align 8
  %44 = extractvalue { i8*, i32 } %42, 1
  store i32 %44, i32* %ehselector.slot, align 4
  call void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev(%"class.std::__1::basic_ofstream"* %log_stream) #1
  br label %eh.resume

eh.resume:                                        ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val3 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val3
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr void @_ZN6loggerD2Ev(%class.logger* %this) unnamed_addr #2 comdat align 2 {
entry:
  %this.addr = alloca %class.logger*, align 8
  store %class.logger* %this, %class.logger** %this.addr, align 8
  %this1 = load %class.logger*, %class.logger** %this.addr, align 8
  %log_stream = getelementptr inbounds %class.logger, %class.logger* %this1, i32 0, i32 0
  call void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev(%"class.std::__1::basic_ofstream"* %log_stream) #1
  ret void
}

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: nounwind
declare void @__cxa_guard_abort(i64*) #1

; Function Attrs: nounwind
declare void @__cxa_guard_release(i64*) #1

; Function Attrs: uwtable
define linkonce_odr void @_ZN6logger6finishEv(%class.logger* %this) #0 comdat align 2 {
entry:
  %this.addr.i.i.i = alloca %"class.std::__1::ios_base"*, align 8
  %__state.addr.i.i.i = alloca i32, align 4
  %this.addr.i.i = alloca %"class.std::__1::basic_ios"*, align 8
  %__state.addr.i.i = alloca i32, align 4
  %this.addr.i = alloca %"class.std::__1::basic_ofstream"*, align 8
  %this.addr = alloca %class.logger*, align 8
  store %class.logger* %this, %class.logger** %this.addr, align 8
  %this1 = load %class.logger*, %class.logger** %this.addr, align 8
  %log_stream = getelementptr inbounds %class.logger, %class.logger* %this1, i32 0, i32 0
  store %"class.std::__1::basic_ofstream"* %log_stream, %"class.std::__1::basic_ofstream"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_ofstream"*, %"class.std::__1::basic_ofstream"** %this.addr.i, align 8
  %__sb_.i = getelementptr inbounds %"class.std::__1::basic_ofstream", %"class.std::__1::basic_ofstream"* %this1.i, i32 0, i32 1
  %call.i = call %"class.std::__1::basic_filebuf"* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5closeEv(%"class.std::__1::basic_filebuf"* %__sb_.i)
  %cmp.i = icmp eq %"class.std::__1::basic_filebuf"* %call.i, null
  br i1 %cmp.i, label %if.then.i, label %_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEE5closeEv.exit

if.then.i:                                        ; preds = %entry
  %0 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to i8**
  %vtable.i = load i8*, i8** %0, align 8
  %vbase.offset.ptr.i = getelementptr i8, i8* %vtable.i, i64 -24
  %1 = bitcast i8* %vbase.offset.ptr.i to i64*
  %vbase.offset.i = load i64, i64* %1, align 8
  %2 = bitcast %"class.std::__1::basic_ofstream"* %this1.i to i8*
  %add.ptr.i = getelementptr inbounds i8, i8* %2, i64 %vbase.offset.i
  %3 = bitcast i8* %add.ptr.i to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %3, %"class.std::__1::basic_ios"** %this.addr.i.i, align 8
  store i32 4, i32* %__state.addr.i.i, align 4
  %this1.i.i = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i.i, align 8
  %4 = bitcast %"class.std::__1::basic_ios"* %this1.i.i to %"class.std::__1::ios_base"*
  %5 = load i32, i32* %__state.addr.i.i, align 4
  store %"class.std::__1::ios_base"* %4, %"class.std::__1::ios_base"** %this.addr.i.i.i, align 8
  store i32 %5, i32* %__state.addr.i.i.i, align 4
  %this1.i.i.i = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %this.addr.i.i.i, align 8
  %__rdstate_.i.i.i = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %this1.i.i.i, i32 0, i32 4
  %6 = load i32, i32* %__rdstate_.i.i.i, align 8
  %7 = load i32, i32* %__state.addr.i.i.i, align 4
  %or.i.i.i = or i32 %6, %7
  call void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"* %this1.i.i.i, i32 %or.i.i.i)
  br label %_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEE5closeEv.exit

_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEE5closeEv.exit: ; preds = %entry, %if.then.i
  ret void
}

; Function Attrs: uwtable
define linkonce_odr void @_ZN6logger3logEmmm(%class.logger* %this, i64 %line, i64 %col, i64 %hash) #0 comdat align 2 {
entry:
  %this.addr = alloca %class.logger*, align 8
  %line.addr = alloca i64, align 8
  %col.addr = alloca i64, align 8
  %hash.addr = alloca i64, align 8
  store %class.logger* %this, %class.logger** %this.addr, align 8
  store i64 %line, i64* %line.addr, align 8
  store i64 %col, i64* %col.addr, align 8
  store i64 %hash, i64* %hash.addr, align 8
  %this1 = load %class.logger*, %class.logger** %this.addr, align 8
  %log_stream = getelementptr inbounds %class.logger, %class.logger* %this1, i32 0, i32 0
  %0 = bitcast %"class.std::__1::basic_ofstream"* %log_stream to %"class.std::__1::basic_ostream"*
  %1 = load i64, i64* %line.addr, align 8
  %call = call dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm(%"class.std::__1::basic_ostream"* %0, i64 %1)
  %2 = load i64, i64* %col.addr, align 8
  %call2 = call dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm(%"class.std::__1::basic_ostream"* %call, i64 %2)
  %3 = load i64, i64* %hash.addr, align 8
  %call3 = call dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm(%"class.std::__1::basic_ostream"* %call2, i64 %3)
  %call4 = call dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc(%"class.std::__1::basic_ostream"* dereferenceable(160) %call3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.13, i32 0, i32 0))
  ret void
}

; Function Attrs: uwtable
define linkonce_odr void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEE4openEPKcj(%"class.std::__1::basic_ofstream"* %this, i8* %__s, i32 %__mode) #0 comdat align 2 {
entry:
  %this.addr.i.i = alloca %"class.std::__1::ios_base"*, align 8
  %__state.addr.i.i = alloca i32, align 4
  %this.addr.i6 = alloca %"class.std::__1::basic_ios"*, align 8
  %__state.addr.i7 = alloca i32, align 4
  %this.addr.i = alloca %"class.std::__1::basic_ios"*, align 8
  %__state.addr.i = alloca i32, align 4
  %this.addr = alloca %"class.std::__1::basic_ofstream"*, align 8
  %__s.addr = alloca i8*, align 8
  %__mode.addr = alloca i32, align 4
  store %"class.std::__1::basic_ofstream"* %this, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  store i8* %__s, i8** %__s.addr, align 8
  store i32 %__mode, i32* %__mode.addr, align 4
  %this1 = load %"class.std::__1::basic_ofstream"*, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  %__sb_ = getelementptr inbounds %"class.std::__1::basic_ofstream", %"class.std::__1::basic_ofstream"* %this1, i32 0, i32 1
  %0 = load i8*, i8** %__s.addr, align 8
  %1 = load i32, i32* %__mode.addr, align 4
  %or = or i32 %1, 16
  %call = call %"class.std::__1::basic_filebuf"* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4openEPKcj(%"class.std::__1::basic_filebuf"* %__sb_, i8* %0, i32 %or)
  %tobool = icmp ne %"class.std::__1::basic_filebuf"* %call, null
  br i1 %tobool, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8**
  %vtable = load i8*, i8** %2, align 8
  %vbase.offset.ptr = getelementptr i8, i8* %vtable, i64 -24
  %3 = bitcast i8* %vbase.offset.ptr to i64*
  %vbase.offset = load i64, i64* %3, align 8
  %4 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8*
  %add.ptr = getelementptr inbounds i8, i8* %4, i64 %vbase.offset
  %5 = bitcast i8* %add.ptr to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %5, %"class.std::__1::basic_ios"** %this.addr.i, align 8
  store i32 0, i32* %__state.addr.i, align 4
  %this1.i = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i, align 8
  %6 = bitcast %"class.std::__1::basic_ios"* %this1.i to %"class.std::__1::ios_base"*
  %7 = load i32, i32* %__state.addr.i, align 4
  call void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"* %6, i32 %7)
  br label %if.end

if.else:                                          ; preds = %entry
  %8 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8**
  %vtable2 = load i8*, i8** %8, align 8
  %vbase.offset.ptr3 = getelementptr i8, i8* %vtable2, i64 -24
  %9 = bitcast i8* %vbase.offset.ptr3 to i64*
  %vbase.offset4 = load i64, i64* %9, align 8
  %10 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8*
  %add.ptr5 = getelementptr inbounds i8, i8* %10, i64 %vbase.offset4
  %11 = bitcast i8* %add.ptr5 to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %11, %"class.std::__1::basic_ios"** %this.addr.i6, align 8
  store i32 4, i32* %__state.addr.i7, align 4
  %this1.i8 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i6, align 8
  %12 = bitcast %"class.std::__1::basic_ios"* %this1.i8 to %"class.std::__1::ios_base"*
  %13 = load i32, i32* %__state.addr.i7, align 4
  store %"class.std::__1::ios_base"* %12, %"class.std::__1::ios_base"** %this.addr.i.i, align 8
  store i32 %13, i32* %__state.addr.i.i, align 4
  %this1.i.i = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %this.addr.i.i, align 8
  %__rdstate_.i.i = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %this1.i.i, i32 0, i32 4
  %14 = load i32, i32* %__rdstate_.i.i, align 8
  %15 = load i32, i32* %__state.addr.i.i, align 4
  %or.i.i = or i32 %14, %15
  call void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"* %this1.i.i, i32 %or.i.i)
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev(%"class.std::__1::basic_ofstream"* %this) unnamed_addr #2 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::__1::basic_ofstream"*, align 8
  store %"class.std::__1::basic_ofstream"* %this, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_ofstream"*, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  call void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_ofstream"* %this1, i8** getelementptr inbounds ([4 x i8*], [4 x i8*]* @_ZTTNSt3__114basic_ofstreamIcNS_11char_traitsIcEEEE, i64 0, i64 0)) #1
  %0 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8*
  %1 = getelementptr inbounds i8, i8* %0, i64 176
  %2 = bitcast i8* %1 to %"class.std::__1::basic_ios"*
  call void @_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_ios"* %2) #1
  ret void
}

; Function Attrs: uwtable
define linkonce_odr void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEEC2Ev(%"class.std::__1::basic_filebuf"* %this) unnamed_addr #0 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr.i20 = alloca %"class.std::__1::codecvt"*, align 8
  %__l.addr.i17 = alloca %"class.std::__1::locale"*, align 8
  %this.addr.i14 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__l.addr.i = alloca %"class.std::__1::locale"*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %ref.tmp = alloca %"class.std::__1::locale", align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %ref.tmp2 = alloca %"class.std::__1::locale", align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %0 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  call void @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEEC2Ev(%"class.std::__1::basic_streambuf"* %0)
  %1 = bitcast %"class.std::__1::basic_filebuf"* %this1 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*], [16 x i8*]* @_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE, i32 0, i32 2) to i32 (...)**), i32 (...)*** %1, align 8
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  store i8* null, i8** %__extbuf_, align 8
  %__extbufnext_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  store i8* null, i8** %__extbufnext_, align 8
  %__extbufend_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  store i8* null, i8** %__extbufend_, align 8
  %__ebs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  store i64 0, i64* %__ebs_, align 8
  %__intbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  store i8* null, i8** %__intbuf_, align 8
  %__ibs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  store i64 0, i64* %__ibs_, align 8
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  store %struct._IO_FILE* null, %struct._IO_FILE** %__file_, align 8
  %__cv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  store %"class.std::__1::codecvt"* null, %"class.std::__1::codecvt"** %__cv_, align 8
  %__st_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 10
  %2 = bitcast %struct.__mbstate_t* %__st_ to i8*
  call void @llvm.memset.p0i8.i64(i8* %2, i8 0, i64 8, i32 8, i1 false)
  %__st_last_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 11
  %3 = bitcast %struct.__mbstate_t* %__st_last_ to i8*
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 8, i32 8, i1 false)
  %__om_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 12
  store i32 0, i32* %__om_, align 8
  %__cm_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 13
  store i32 0, i32* %__cm_, align 4
  %__owns_eb_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  store i8 0, i8* %__owns_eb_, align 8
  %__owns_ib_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  store i8 0, i8* %__owns_ib_, align 1
  %__always_noconv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  store i8 0, i8* %__always_noconv_, align 2
  %4 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %4, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8, !noalias !1
  %this1.i = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8, !noalias !1
  %__loc_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 1
  call void @_ZNSt3__16localeC1ERKS0_(%"class.std::__1::locale"* %ref.tmp, %"class.std::__1::locale"* dereferenceable(8) %__loc_.i) #1
  br label %invoke.cont

invoke.cont:                                      ; preds = %entry
  store %"class.std::__1::locale"* %ref.tmp, %"class.std::__1::locale"** %__l.addr.i, align 8
  %5 = load %"class.std::__1::locale"*, %"class.std::__1::locale"** %__l.addr.i, align 8
  %call.i = invoke zeroext i1 @_ZNKSt3__16locale9has_facetERNS0_2idE(%"class.std::__1::locale"* %5, %"class.std::__1::locale::id"* dereferenceable(16) @_ZNSt3__17codecvtIcc11__mbstate_tE2idE)
          to label %_ZNSt3__19has_facetINS_7codecvtIcc11__mbstate_tEEEEbRKNS_6localeE.exit unwind label %terminate.lpad.i

terminate.lpad.i:                                 ; preds = %invoke.cont
  %6 = landingpad { i8*, i32 }
          catch i8* null
  %7 = extractvalue { i8*, i32 } %6, 0
  call void @__clang_call_terminate(i8* %7) #12
  unreachable

_ZNSt3__19has_facetINS_7codecvtIcc11__mbstate_tEEEEbRKNS_6localeE.exit: ; preds = %invoke.cont
  call void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* %ref.tmp) #1
  br i1 %call.i, label %if.then, label %if.end

if.then:                                          ; preds = %_ZNSt3__19has_facetINS_7codecvtIcc11__mbstate_tEEEEbRKNS_6localeE.exit
  %8 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %8, %"class.std::__1::basic_streambuf"** %this.addr.i14, align 8, !noalias !4
  %this1.i15 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i14, align 8, !noalias !4
  %__loc_.i16 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i15, i32 0, i32 1
  call void @_ZNSt3__16localeC1ERKS0_(%"class.std::__1::locale"* %ref.tmp2, %"class.std::__1::locale"* dereferenceable(8) %__loc_.i16) #1
  br label %invoke.cont3

invoke.cont3:                                     ; preds = %if.then
  store %"class.std::__1::locale"* %ref.tmp2, %"class.std::__1::locale"** %__l.addr.i17, align 8
  %9 = load %"class.std::__1::locale"*, %"class.std::__1::locale"** %__l.addr.i17, align 8
  %call.i1819 = invoke %"class.std::__1::locale::facet"* @_ZNKSt3__16locale9use_facetERNS0_2idE(%"class.std::__1::locale"* %9, %"class.std::__1::locale::id"* dereferenceable(16) @_ZNSt3__17codecvtIcc11__mbstate_tE2idE)
          to label %_ZNSt3__19use_facetINS_7codecvtIcc11__mbstate_tEEEERKT_RKNS_6localeE.exit unwind label %lpad4

_ZNSt3__19use_facetINS_7codecvtIcc11__mbstate_tEEEERKT_RKNS_6localeE.exit: ; preds = %invoke.cont3
  %10 = bitcast %"class.std::__1::locale::facet"* %call.i1819 to %"class.std::__1::codecvt"*
  br label %invoke.cont5

invoke.cont5:                                     ; preds = %_ZNSt3__19use_facetINS_7codecvtIcc11__mbstate_tEEEERKT_RKNS_6localeE.exit
  %__cv_7 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  store %"class.std::__1::codecvt"* %10, %"class.std::__1::codecvt"** %__cv_7, align 8
  call void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* %ref.tmp2) #1
  %__cv_8 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %11 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_8, align 8
  store %"class.std::__1::codecvt"* %11, %"class.std::__1::codecvt"** %this.addr.i20, align 8
  %this1.i21 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %this.addr.i20, align 8
  %12 = bitcast %"class.std::__1::codecvt"* %this1.i21 to i1 (%"class.std::__1::codecvt"*)***
  %vtable.i = load i1 (%"class.std::__1::codecvt"*)**, i1 (%"class.std::__1::codecvt"*)*** %12, align 8
  %vfn.i = getelementptr inbounds i1 (%"class.std::__1::codecvt"*)*, i1 (%"class.std::__1::codecvt"*)** %vtable.i, i64 7
  %13 = load i1 (%"class.std::__1::codecvt"*)*, i1 (%"class.std::__1::codecvt"*)** %vfn.i, align 8
  %call.i22 = call zeroext i1 %13(%"class.std::__1::codecvt"* %this1.i21) #1
  %__always_noconv_10 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %frombool = zext i1 %call.i22 to i8
  store i8 %frombool, i8* %__always_noconv_10, align 2
  br label %if.end

lpad:                                             ; preds = %if.end
  %14 = landingpad { i8*, i32 }
          cleanup
  %15 = extractvalue { i8*, i32 } %14, 0
  store i8* %15, i8** %exn.slot, align 8
  %16 = extractvalue { i8*, i32 } %14, 1
  store i32 %16, i32* %ehselector.slot, align 4
  br label %ehcleanup

lpad4:                                            ; preds = %invoke.cont3
  %17 = landingpad { i8*, i32 }
          cleanup
  %18 = extractvalue { i8*, i32 } %17, 0
  store i8* %18, i8** %exn.slot, align 8
  %19 = extractvalue { i8*, i32 } %17, 1
  store i32 %19, i32* %ehselector.slot, align 4
  call void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* %ref.tmp2) #1
  br label %ehcleanup

if.end:                                           ; preds = %invoke.cont5, %_ZNSt3__19has_facetINS_7codecvtIcc11__mbstate_tEEEEbRKNS_6localeE.exit
  %20 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"* (%"class.std::__1::basic_filebuf"*, i8*, i64)***
  %vtable = load %"class.std::__1::basic_streambuf"* (%"class.std::__1::basic_filebuf"*, i8*, i64)**, %"class.std::__1::basic_streambuf"* (%"class.std::__1::basic_filebuf"*, i8*, i64)*** %20, align 8
  %vfn = getelementptr inbounds %"class.std::__1::basic_streambuf"* (%"class.std::__1::basic_filebuf"*, i8*, i64)*, %"class.std::__1::basic_streambuf"* (%"class.std::__1::basic_filebuf"*, i8*, i64)** %vtable, i64 3
  %21 = load %"class.std::__1::basic_streambuf"* (%"class.std::__1::basic_filebuf"*, i8*, i64)*, %"class.std::__1::basic_streambuf"* (%"class.std::__1::basic_filebuf"*, i8*, i64)** %vfn, align 8
  %call12 = invoke %"class.std::__1::basic_streambuf"* %21(%"class.std::__1::basic_filebuf"* %this1, i8* null, i64 4096)
          to label %invoke.cont11 unwind label %lpad

invoke.cont11:                                    ; preds = %if.end
  ret void

ehcleanup:                                        ; preds = %lpad4, %lpad
  %22 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  call void @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_streambuf"* %22) #1
  br label %eh.resume

eh.resume:                                        ; preds = %ehcleanup
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val13 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val13
}

; Function Attrs: nounwind
declare void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_ostream"*, i8**) unnamed_addr #3

; Function Attrs: nounwind
declare void @_ZNSt3__19basic_iosIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_ios"*) unnamed_addr #3

; Function Attrs: nounwind
declare void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEED1Ev(%"class.std::__1::basic_ostream"*) unnamed_addr #3

; Function Attrs: nounwind
declare void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEED0Ev(%"class.std::__1::basic_ostream"*) unnamed_addr #3

; Function Attrs: nounwind
declare void @_ZTv0_n24_NSt3__113basic_ostreamIcNS_11char_traitsIcEEED1Ev(%"class.std::__1::basic_ostream"*) unnamed_addr #3

; Function Attrs: nounwind
declare void @_ZTv0_n24_NSt3__113basic_ostreamIcNS_11char_traitsIcEEED0Ev(%"class.std::__1::basic_ostream"*) unnamed_addr #3

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED0Ev(%"class.std::__1::basic_ofstream"* %this) unnamed_addr #2 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::__1::basic_ofstream"*, align 8
  store %"class.std::__1::basic_ofstream"* %this, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_ofstream"*, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  call void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev(%"class.std::__1::basic_ofstream"* %this1) #1
  %0 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8*
  call void @_ZdlPv(i8* %0) #13
  ret void
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZTv0_n24_NSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev(%"class.std::__1::basic_ofstream"* %this) unnamed_addr #4 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::__1::basic_ofstream"*, align 8
  store %"class.std::__1::basic_ofstream"* %this, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_ofstream"*, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  %0 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8*
  %1 = bitcast i8* %0 to i8**
  %2 = load i8*, i8** %1, align 8
  %3 = getelementptr inbounds i8, i8* %2, i64 -24
  %4 = bitcast i8* %3 to i64*
  %5 = load i64, i64* %4, align 8
  %6 = getelementptr inbounds i8, i8* %0, i64 %5
  %7 = bitcast i8* %6 to %"class.std::__1::basic_ofstream"*
  tail call void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED1Ev(%"class.std::__1::basic_ofstream"* %7) #1
  ret void
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZTv0_n24_NSt3__114basic_ofstreamIcNS_11char_traitsIcEEED0Ev(%"class.std::__1::basic_ofstream"* %this) unnamed_addr #4 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::__1::basic_ofstream"*, align 8
  store %"class.std::__1::basic_ofstream"* %this, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_ofstream"*, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  %0 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8*
  %1 = bitcast i8* %0 to i8**
  %2 = load i8*, i8** %1, align 8
  %3 = getelementptr inbounds i8, i8* %2, i64 -24
  %4 = bitcast i8* %3 to i64*
  %5 = load i64, i64* %4, align 8
  %6 = getelementptr inbounds i8, i8* %0, i64 %5
  %7 = bitcast i8* %6 to %"class.std::__1::basic_ofstream"*
  tail call void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED0Ev(%"class.std::__1::basic_ofstream"* %7) #1
  ret void
}

declare void @_ZNSt3__18ios_base4initEPv(%"class.std::__1::ios_base"*, i8*) #5

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr i32 @_ZNSt3__111char_traitsIcE3eofEv() #2 comdat align 2 {
entry:
  ret i32 -1
}

declare void @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEEC2Ev(%"class.std::__1::basic_streambuf"*) unnamed_addr #5

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #6

; Function Attrs: nounwind
declare void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"*) unnamed_addr #3

; Function Attrs: nounwind
declare void @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_streambuf"*) unnamed_addr #3

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_filebuf"* %this) unnamed_addr #4 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %0 = bitcast %"class.std::__1::basic_filebuf"* %this1 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*], [16 x i8*]* @_ZTVNSt3__113basic_filebufIcNS_11char_traitsIcEEEE, i32 0, i32 2) to i32 (...)**), i32 (...)*** %0, align 8
  %call = invoke %"class.std::__1::basic_filebuf"* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5closeEv(%"class.std::__1::basic_filebuf"* %this1)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  br label %try.cont

lpad:                                             ; preds = %entry
  %1 = landingpad { i8*, i32 }
          catch i8* null
  %2 = extractvalue { i8*, i32 } %1, 0
  store i8* %2, i8** %exn.slot, align 8
  %3 = extractvalue { i8*, i32 } %1, 1
  store i32 %3, i32* %ehselector.slot, align 4
  br label %catch

catch:                                            ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  %4 = call i8* @__cxa_begin_catch(i8* %exn) #1
  invoke void @__cxa_end_catch()
          to label %invoke.cont3 unwind label %lpad2

invoke.cont3:                                     ; preds = %catch
  br label %try.cont

try.cont:                                         ; preds = %invoke.cont3, %invoke.cont
  %__owns_eb_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  %5 = load i8, i8* %__owns_eb_, align 8
  %tobool = trunc i8 %5 to i1
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %try.cont
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %6 = load i8*, i8** %__extbuf_, align 8
  %isnull = icmp eq i8* %6, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %if.then
  call void @_ZdaPv(i8* %6) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %if.then
  br label %if.end

lpad2:                                            ; preds = %catch
  %7 = landingpad { i8*, i32 }
          catch i8* null
  %8 = extractvalue { i8*, i32 } %7, 0
  store i8* %8, i8** %exn.slot, align 8
  %9 = extractvalue { i8*, i32 } %7, 1
  store i32 %9, i32* %ehselector.slot, align 4
  %10 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  call void @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_streambuf"* %10) #1
  br label %terminate.handler

if.end:                                           ; preds = %delete.end, %try.cont
  %__owns_ib_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  %11 = load i8, i8* %__owns_ib_, align 1
  %tobool4 = trunc i8 %11 to i1
  br i1 %tobool4, label %if.then5, label %if.end9

if.then5:                                         ; preds = %if.end
  %__intbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  %12 = load i8*, i8** %__intbuf_, align 8
  %isnull6 = icmp eq i8* %12, null
  br i1 %isnull6, label %delete.end8, label %delete.notnull7

delete.notnull7:                                  ; preds = %if.then5
  call void @_ZdaPv(i8* %12) #13
  br label %delete.end8

delete.end8:                                      ; preds = %delete.notnull7, %if.then5
  br label %if.end9

if.end9:                                          ; preds = %delete.end8, %if.end
  %13 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  call void @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_streambuf"* %13) #1
  ret void

terminate.handler:                                ; preds = %lpad2
  %exn10 = load i8*, i8** %exn.slot, align 8
  call void @__clang_call_terminate(i8* %exn10) #12
  unreachable
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED0Ev(%"class.std::__1::basic_filebuf"* %this) unnamed_addr #4 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  call void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_filebuf"* %this1) #1
  %0 = bitcast %"class.std::__1::basic_filebuf"* %this1 to i8*
  call void @_ZdlPv(i8* %0) #13
  ret void
}

; Function Attrs: uwtable
define linkonce_odr void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5imbueERKNS_6localeE(%"class.std::__1::basic_filebuf"* %this, %"class.std::__1::locale"* dereferenceable(8) %__loc) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr.i50 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i = alloca i8*, align 8
  %__pend.addr.i = alloca i8*, align 8
  %this.addr.i48 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i = alloca i8*, align 8
  %__gnext.addr.i = alloca i8*, align 8
  %__gend.addr.i = alloca i8*, align 8
  %this.addr.i = alloca %"class.std::__1::codecvt"*, align 8
  %__l.addr.i = alloca %"class.std::__1::locale"*, align 8
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__loc.addr = alloca %"class.std::__1::locale"*, align 8
  %__old_anc = alloca i8, align 1
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store %"class.std::__1::locale"* %__loc, %"class.std::__1::locale"** %__loc.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %0 = bitcast %"class.std::__1::basic_filebuf"* %this1 to i32 (%"class.std::__1::basic_filebuf"*)***
  %vtable = load i32 (%"class.std::__1::basic_filebuf"*)**, i32 (%"class.std::__1::basic_filebuf"*)*** %0, align 8
  %vfn = getelementptr inbounds i32 (%"class.std::__1::basic_filebuf"*)*, i32 (%"class.std::__1::basic_filebuf"*)** %vtable, i64 6
  %1 = load i32 (%"class.std::__1::basic_filebuf"*)*, i32 (%"class.std::__1::basic_filebuf"*)** %vfn, align 8
  %call = call i32 %1(%"class.std::__1::basic_filebuf"* %this1)
  %2 = load %"class.std::__1::locale"*, %"class.std::__1::locale"** %__loc.addr, align 8
  store %"class.std::__1::locale"* %2, %"class.std::__1::locale"** %__l.addr.i, align 8
  %3 = load %"class.std::__1::locale"*, %"class.std::__1::locale"** %__l.addr.i, align 8
  %call.i = call %"class.std::__1::locale::facet"* @_ZNKSt3__16locale9use_facetERNS0_2idE(%"class.std::__1::locale"* %3, %"class.std::__1::locale::id"* dereferenceable(16) @_ZNSt3__17codecvtIcc11__mbstate_tE2idE)
  %4 = bitcast %"class.std::__1::locale::facet"* %call.i to %"class.std::__1::codecvt"*
  %__cv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  store %"class.std::__1::codecvt"* %4, %"class.std::__1::codecvt"** %__cv_, align 8
  %__always_noconv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %5 = load i8, i8* %__always_noconv_, align 2
  %tobool = trunc i8 %5 to i1
  %frombool = zext i1 %tobool to i8
  store i8 %frombool, i8* %__old_anc, align 1
  %__cv_3 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %6 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_3, align 8
  store %"class.std::__1::codecvt"* %6, %"class.std::__1::codecvt"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %this.addr.i, align 8
  %7 = bitcast %"class.std::__1::codecvt"* %this1.i to i1 (%"class.std::__1::codecvt"*)***
  %vtable.i = load i1 (%"class.std::__1::codecvt"*)**, i1 (%"class.std::__1::codecvt"*)*** %7, align 8
  %vfn.i = getelementptr inbounds i1 (%"class.std::__1::codecvt"*)*, i1 (%"class.std::__1::codecvt"*)** %vtable.i, i64 7
  %8 = load i1 (%"class.std::__1::codecvt"*)*, i1 (%"class.std::__1::codecvt"*)** %vfn.i, align 8
  %call.i47 = call zeroext i1 %8(%"class.std::__1::codecvt"* %this1.i) #1
  %__always_noconv_5 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %frombool6 = zext i1 %call.i47 to i8
  store i8 %frombool6, i8* %__always_noconv_5, align 2
  %9 = load i8, i8* %__old_anc, align 1
  %tobool7 = trunc i8 %9 to i1
  %conv = zext i1 %tobool7 to i32
  %__always_noconv_8 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %10 = load i8, i8* %__always_noconv_8, align 2
  %tobool9 = trunc i8 %10 to i1
  %conv10 = zext i1 %tobool9 to i32
  %cmp = icmp ne i32 %conv, %conv10
  br i1 %cmp, label %if.then, label %if.end46

if.then:                                          ; preds = %entry
  %11 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %11, %"class.std::__1::basic_streambuf"** %this.addr.i48, align 8
  store i8* null, i8** %__gbeg.addr.i, align 8
  store i8* null, i8** %__gnext.addr.i, align 8
  store i8* null, i8** %__gend.addr.i, align 8
  %this1.i49 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i48, align 8
  %12 = load i8*, i8** %__gbeg.addr.i, align 8
  %__binp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i49, i32 0, i32 2
  store i8* %12, i8** %__binp_.i, align 8
  %13 = load i8*, i8** %__gnext.addr.i, align 8
  %__ninp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i49, i32 0, i32 3
  store i8* %13, i8** %__ninp_.i, align 8
  %14 = load i8*, i8** %__gend.addr.i, align 8
  %__einp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i49, i32 0, i32 4
  store i8* %14, i8** %__einp_.i, align 8
  %15 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %15, %"class.std::__1::basic_streambuf"** %this.addr.i50, align 8
  store i8* null, i8** %__pbeg.addr.i, align 8
  store i8* null, i8** %__pend.addr.i, align 8
  %this1.i51 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i50, align 8
  %16 = load i8*, i8** %__pbeg.addr.i, align 8
  %__nout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i51, i32 0, i32 6
  store i8* %16, i8** %__nout_.i, align 8
  %__bout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i51, i32 0, i32 5
  store i8* %16, i8** %__bout_.i, align 8
  %17 = load i8*, i8** %__pend.addr.i, align 8
  %__eout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i51, i32 0, i32 7
  store i8* %17, i8** %__eout_.i, align 8
  %__always_noconv_11 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %18 = load i8, i8* %__always_noconv_11, align 2
  %tobool12 = trunc i8 %18 to i1
  br i1 %tobool12, label %if.then13, label %if.else

if.then13:                                        ; preds = %if.then
  %__owns_eb_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  %19 = load i8, i8* %__owns_eb_, align 8
  %tobool14 = trunc i8 %19 to i1
  br i1 %tobool14, label %if.then15, label %if.end

if.then15:                                        ; preds = %if.then13
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %20 = load i8*, i8** %__extbuf_, align 8
  %isnull = icmp eq i8* %20, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %if.then15
  call void @_ZdaPv(i8* %20) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %if.then15
  br label %if.end

if.end:                                           ; preds = %delete.end, %if.then13
  %__owns_ib_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  %21 = load i8, i8* %__owns_ib_, align 1
  %tobool16 = trunc i8 %21 to i1
  %__owns_eb_17 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  %frombool18 = zext i1 %tobool16 to i8
  store i8 %frombool18, i8* %__owns_eb_17, align 8
  %__ibs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %22 = load i64, i64* %__ibs_, align 8
  %__ebs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  store i64 %22, i64* %__ebs_, align 8
  %__intbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  %23 = load i8*, i8** %__intbuf_, align 8
  %__extbuf_19 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  store i8* %23, i8** %__extbuf_19, align 8
  %__ibs_20 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  store i64 0, i64* %__ibs_20, align 8
  %__intbuf_21 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  store i8* null, i8** %__intbuf_21, align 8
  %__owns_ib_22 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  store i8 0, i8* %__owns_ib_22, align 1
  br label %if.end45

if.else:                                          ; preds = %if.then
  %__owns_eb_23 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  %24 = load i8, i8* %__owns_eb_23, align 8
  %tobool24 = trunc i8 %24 to i1
  br i1 %tobool24, label %if.else37, label %land.lhs.true

land.lhs.true:                                    ; preds = %if.else
  %__extbuf_25 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %25 = load i8*, i8** %__extbuf_25, align 8
  %__extbuf_min_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 4
  %arraydecay = getelementptr inbounds [8 x i8], [8 x i8]* %__extbuf_min_, i32 0, i32 0
  %cmp26 = icmp ne i8* %25, %arraydecay
  br i1 %cmp26, label %if.then27, label %if.else37

if.then27:                                        ; preds = %land.lhs.true
  %__ebs_28 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %26 = load i64, i64* %__ebs_28, align 8
  %__ibs_29 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  store i64 %26, i64* %__ibs_29, align 8
  %__extbuf_30 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %27 = load i8*, i8** %__extbuf_30, align 8
  %__intbuf_31 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  store i8* %27, i8** %__intbuf_31, align 8
  %__owns_ib_32 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  store i8 0, i8* %__owns_ib_32, align 1
  %__ebs_33 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %28 = load i64, i64* %__ebs_33, align 8
  %call34 = call i8* @_Znam(i64 %28) #14
  %__extbuf_35 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  store i8* %call34, i8** %__extbuf_35, align 8
  %__owns_eb_36 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  store i8 1, i8* %__owns_eb_36, align 8
  br label %if.end44

if.else37:                                        ; preds = %land.lhs.true, %if.else
  %__ebs_38 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %29 = load i64, i64* %__ebs_38, align 8
  %__ibs_39 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  store i64 %29, i64* %__ibs_39, align 8
  %__ibs_40 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %30 = load i64, i64* %__ibs_40, align 8
  %call41 = call i8* @_Znam(i64 %30) #14
  %__intbuf_42 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  store i8* %call41, i8** %__intbuf_42, align 8
  %__owns_ib_43 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  store i8 1, i8* %__owns_ib_43, align 1
  br label %if.end44

if.end44:                                         ; preds = %if.else37, %if.then27
  br label %if.end45

if.end45:                                         ; preds = %if.end44, %if.end
  br label %if.end46

if.end46:                                         ; preds = %if.end45, %entry
  ret void
}

; Function Attrs: uwtable
define linkonce_odr %"class.std::__1::basic_streambuf"* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE6setbufEPcl(%"class.std::__1::basic_filebuf"* %this, i8* %__s, i64 %__n) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr.i46 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i = alloca i8*, align 8
  %__pend.addr.i = alloca i8*, align 8
  %this.addr.i.i.i = alloca %"struct.std::__1::__less"*, align 8
  %__x.addr.i.i.i = alloca i64*, align 8
  %__y.addr.i.i.i = alloca i64*, align 8
  %__comp.i.i = alloca %"struct.std::__1::__less", align 1
  %__a.addr.i.i = alloca i64*, align 8
  %__b.addr.i.i = alloca i64*, align 8
  %__a.addr.i = alloca i64*, align 8
  %__b.addr.i = alloca i64*, align 8
  %agg.tmp.i = alloca %"struct.std::__1::__less", align 1
  %this.addr.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i = alloca i8*, align 8
  %__gnext.addr.i = alloca i8*, align 8
  %__gend.addr.i = alloca i8*, align 8
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__s.addr = alloca i8*, align 8
  %__n.addr = alloca i64, align 8
  %ref.tmp = alloca i64, align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store i8* %__s, i8** %__s.addr, align 8
  store i64 %__n, i64* %__n.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %0 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %0, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  store i8* null, i8** %__gbeg.addr.i, align 8
  store i8* null, i8** %__gnext.addr.i, align 8
  store i8* null, i8** %__gend.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %1 = load i8*, i8** %__gbeg.addr.i, align 8
  %__binp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 2
  store i8* %1, i8** %__binp_.i, align 8
  %2 = load i8*, i8** %__gnext.addr.i, align 8
  %__ninp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 3
  store i8* %2, i8** %__ninp_.i, align 8
  %3 = load i8*, i8** %__gend.addr.i, align 8
  %__einp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 4
  store i8* %3, i8** %__einp_.i, align 8
  %4 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %4, %"class.std::__1::basic_streambuf"** %this.addr.i46, align 8
  store i8* null, i8** %__pbeg.addr.i, align 8
  store i8* null, i8** %__pend.addr.i, align 8
  %this1.i47 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i46, align 8
  %5 = load i8*, i8** %__pbeg.addr.i, align 8
  %__nout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i47, i32 0, i32 6
  store i8* %5, i8** %__nout_.i, align 8
  %__bout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i47, i32 0, i32 5
  store i8* %5, i8** %__bout_.i, align 8
  %6 = load i8*, i8** %__pend.addr.i, align 8
  %__eout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i47, i32 0, i32 7
  store i8* %6, i8** %__eout_.i, align 8
  %__owns_eb_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  %7 = load i8, i8* %__owns_eb_, align 8
  %tobool = trunc i8 %7 to i1
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %8 = load i8*, i8** %__extbuf_, align 8
  %isnull = icmp eq i8* %8, null
  br i1 %isnull, label %delete.end, label %delete.notnull

delete.notnull:                                   ; preds = %if.then
  call void @_ZdaPv(i8* %8) #13
  br label %delete.end

delete.end:                                       ; preds = %delete.notnull, %if.then
  br label %if.end

if.end:                                           ; preds = %delete.end, %entry
  %__owns_ib_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  %9 = load i8, i8* %__owns_ib_, align 1
  %tobool2 = trunc i8 %9 to i1
  br i1 %tobool2, label %if.then3, label %if.end7

if.then3:                                         ; preds = %if.end
  %__intbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  %10 = load i8*, i8** %__intbuf_, align 8
  %isnull4 = icmp eq i8* %10, null
  br i1 %isnull4, label %delete.end6, label %delete.notnull5

delete.notnull5:                                  ; preds = %if.then3
  call void @_ZdaPv(i8* %10) #13
  br label %delete.end6

delete.end6:                                      ; preds = %delete.notnull5, %if.then3
  br label %if.end7

if.end7:                                          ; preds = %delete.end6, %if.end
  %11 = load i64, i64* %__n.addr, align 8
  %__ebs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  store i64 %11, i64* %__ebs_, align 8
  %__ebs_8 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %12 = load i64, i64* %__ebs_8, align 8
  %cmp = icmp ugt i64 %12, 8
  br i1 %cmp, label %if.then9, label %if.else19

if.then9:                                         ; preds = %if.end7
  %__always_noconv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %13 = load i8, i8* %__always_noconv_, align 2
  %tobool10 = trunc i8 %13 to i1
  br i1 %tobool10, label %land.lhs.true, label %if.else

land.lhs.true:                                    ; preds = %if.then9
  %14 = load i8*, i8** %__s.addr, align 8
  %tobool11 = icmp ne i8* %14, null
  br i1 %tobool11, label %if.then12, label %if.else

if.then12:                                        ; preds = %land.lhs.true
  %15 = load i8*, i8** %__s.addr, align 8
  %__extbuf_13 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  store i8* %15, i8** %__extbuf_13, align 8
  %__owns_eb_14 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  store i8 0, i8* %__owns_eb_14, align 8
  br label %if.end18

if.else:                                          ; preds = %land.lhs.true, %if.then9
  %__ebs_15 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %16 = load i64, i64* %__ebs_15, align 8
  %call = call i8* @_Znam(i64 %16) #14
  %__extbuf_16 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  store i8* %call, i8** %__extbuf_16, align 8
  %__owns_eb_17 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  store i8 1, i8* %__owns_eb_17, align 8
  br label %if.end18

if.end18:                                         ; preds = %if.else, %if.then12
  br label %if.end23

if.else19:                                        ; preds = %if.end7
  %__extbuf_min_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 4
  %arraydecay = getelementptr inbounds [8 x i8], [8 x i8]* %__extbuf_min_, i32 0, i32 0
  %__extbuf_20 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  store i8* %arraydecay, i8** %__extbuf_20, align 8
  %__ebs_21 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  store i64 8, i64* %__ebs_21, align 8
  %__owns_eb_22 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 14
  store i8 0, i8* %__owns_eb_22, align 8
  br label %if.end23

if.end23:                                         ; preds = %if.else19, %if.end18
  %__always_noconv_24 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %17 = load i8, i8* %__always_noconv_24, align 2
  %tobool25 = trunc i8 %17 to i1
  br i1 %tobool25, label %if.else41, label %if.then26

if.then26:                                        ; preds = %if.end23
  store i64 8, i64* %ref.tmp, align 8
  store i64* %__n.addr, i64** %__a.addr.i, align 8
  store i64* %ref.tmp, i64** %__b.addr.i, align 8
  %18 = load i64*, i64** %__a.addr.i, align 8
  %19 = load i64*, i64** %__b.addr.i, align 8
  store i64* %18, i64** %__a.addr.i.i, align 8
  store i64* %19, i64** %__b.addr.i.i, align 8
  %20 = load i64*, i64** %__a.addr.i.i, align 8
  %21 = load i64*, i64** %__b.addr.i.i, align 8
  store %"struct.std::__1::__less"* %__comp.i.i, %"struct.std::__1::__less"** %this.addr.i.i.i, align 8
  store i64* %20, i64** %__x.addr.i.i.i, align 8
  store i64* %21, i64** %__y.addr.i.i.i, align 8
  %this1.i.i.i = load %"struct.std::__1::__less"*, %"struct.std::__1::__less"** %this.addr.i.i.i, align 8
  %22 = load i64*, i64** %__x.addr.i.i.i, align 8
  %23 = load i64, i64* %22, align 8
  %24 = load i64*, i64** %__y.addr.i.i.i, align 8
  %25 = load i64, i64* %24, align 8
  %cmp.i.i.i = icmp slt i64 %23, %25
  br i1 %cmp.i.i.i, label %cond.true.i.i, label %cond.false.i.i

cond.true.i.i:                                    ; preds = %if.then26
  %26 = load i64*, i64** %__b.addr.i.i, align 8
  br label %_ZNSt3__13maxIlEERKT_S3_S3_.exit

cond.false.i.i:                                   ; preds = %if.then26
  %27 = load i64*, i64** %__a.addr.i.i, align 8
  br label %_ZNSt3__13maxIlEERKT_S3_S3_.exit

_ZNSt3__13maxIlEERKT_S3_S3_.exit:                 ; preds = %cond.true.i.i, %cond.false.i.i
  %cond-lvalue.i.i = phi i64* [ %26, %cond.true.i.i ], [ %27, %cond.false.i.i ]
  %28 = load i64, i64* %cond-lvalue.i.i, align 8
  %__ibs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  store i64 %28, i64* %__ibs_, align 8
  %29 = load i8*, i8** %__s.addr, align 8
  %tobool28 = icmp ne i8* %29, null
  br i1 %tobool28, label %land.lhs.true29, label %if.else35

land.lhs.true29:                                  ; preds = %_ZNSt3__13maxIlEERKT_S3_S3_.exit
  %__ibs_30 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %30 = load i64, i64* %__ibs_30, align 8
  %cmp31 = icmp uge i64 %30, 8
  br i1 %cmp31, label %if.then32, label %if.else35

if.then32:                                        ; preds = %land.lhs.true29
  %31 = load i8*, i8** %__s.addr, align 8
  %__intbuf_33 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  store i8* %31, i8** %__intbuf_33, align 8
  %__owns_ib_34 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  store i8 0, i8* %__owns_ib_34, align 1
  br label %if.end40

if.else35:                                        ; preds = %land.lhs.true29, %_ZNSt3__13maxIlEERKT_S3_S3_.exit
  %__ibs_36 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %32 = load i64, i64* %__ibs_36, align 8
  %call37 = call i8* @_Znam(i64 %32) #14
  %__intbuf_38 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  store i8* %call37, i8** %__intbuf_38, align 8
  %__owns_ib_39 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  store i8 1, i8* %__owns_ib_39, align 1
  br label %if.end40

if.end40:                                         ; preds = %if.else35, %if.then32
  br label %if.end45

if.else41:                                        ; preds = %if.end23
  %__ibs_42 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  store i64 0, i64* %__ibs_42, align 8
  %__intbuf_43 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  store i8* null, i8** %__intbuf_43, align 8
  %__owns_ib_44 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 15
  store i8 0, i8* %__owns_ib_44, align 1
  br label %if.end45

if.end45:                                         ; preds = %if.else41, %if.end40
  %33 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  ret %"class.std::__1::basic_streambuf"* %33
}

; Function Attrs: uwtable
define linkonce_odr { i64, i64 } @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekoffExNS_8ios_base7seekdirEj(%"class.std::__1::basic_filebuf"* %this, i64 %__off, i32 %__way, i32) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr.i35 = alloca %"class.std::__1::fpos"*, align 8
  %__off.addr.i36 = alloca i64, align 8
  %__st.i = alloca %struct.__mbstate_t, align 4
  %this.addr.i32 = alloca %"class.std::__1::fpos"*, align 8
  %this.addr.i27 = alloca %"class.std::__1::fpos"*, align 8
  %__off.addr.i28 = alloca i64, align 8
  %this.addr.i22 = alloca %"class.std::__1::fpos"*, align 8
  %__off.addr.i23 = alloca i64, align 8
  %this.addr.i20 = alloca %"class.std::__1::fpos"*, align 8
  %__off.addr.i = alloca i64, align 8
  %this.addr.i = alloca %"class.std::__1::codecvt"*, align 8
  %retval = alloca %"class.std::__1::fpos", align 8
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__off.addr = alloca i64, align 8
  %__way.addr = alloca i32, align 4
  %.addr = alloca i32, align 4
  %__width = alloca i32, align 4
  %__whence = alloca i32, align 4
  %__r = alloca %"class.std::__1::fpos", align 8
  %agg.tmp = alloca %struct.__mbstate_t, align 4
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store i64 %__off, i64* %__off.addr, align 8
  store i32 %__way, i32* %__way.addr, align 4
  store i32 %0, i32* %.addr, align 4
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %__cv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %1 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_, align 8
  %tobool = icmp ne %"class.std::__1::codecvt"* %1, null
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  %exception.i = call i8* @__cxa_allocate_exception(i64 8) #1
  %2 = bitcast i8* %exception.i to %"class.std::bad_cast"*
  call void @_ZNSt8bad_castC1Ev(%"class.std::bad_cast"* %2) #1
  call void @__cxa_throw(i8* %exception.i, i8* bitcast (i8** @_ZTISt8bad_cast to i8*), i8* bitcast (void (%"class.std::bad_cast"*)* @_ZNSt8bad_castD1Ev to i8*)) #15
  unreachable

_ZNSt3__116__throw_bad_castEv.exit:               ; No predecessors!
  unreachable

if.end:                                           ; preds = %entry
  %__cv_2 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %3 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_2, align 8
  store %"class.std::__1::codecvt"* %3, %"class.std::__1::codecvt"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %this.addr.i, align 8
  %4 = bitcast %"class.std::__1::codecvt"* %this1.i to i32 (%"class.std::__1::codecvt"*)***
  %vtable.i = load i32 (%"class.std::__1::codecvt"*)**, i32 (%"class.std::__1::codecvt"*)*** %4, align 8
  %vfn.i = getelementptr inbounds i32 (%"class.std::__1::codecvt"*)*, i32 (%"class.std::__1::codecvt"*)** %vtable.i, i64 6
  %5 = load i32 (%"class.std::__1::codecvt"*)*, i32 (%"class.std::__1::codecvt"*)** %vfn.i, align 8
  %call.i = call i32 %5(%"class.std::__1::codecvt"* %this1.i) #1
  store i32 %call.i, i32* %__width, align 4
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_, align 8
  %cmp = icmp eq %struct._IO_FILE* %6, null
  br i1 %cmp, label %if.then8, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %7 = load i32, i32* %__width, align 4
  %cmp3 = icmp sle i32 %7, 0
  br i1 %cmp3, label %land.lhs.true, label %lor.lhs.false5

land.lhs.true:                                    ; preds = %lor.lhs.false
  %8 = load i64, i64* %__off.addr, align 8
  %cmp4 = icmp ne i64 %8, 0
  br i1 %cmp4, label %if.then8, label %lor.lhs.false5

lor.lhs.false5:                                   ; preds = %land.lhs.true, %lor.lhs.false
  %9 = bitcast %"class.std::__1::basic_filebuf"* %this1 to i32 (%"class.std::__1::basic_filebuf"*)***
  %vtable = load i32 (%"class.std::__1::basic_filebuf"*)**, i32 (%"class.std::__1::basic_filebuf"*)*** %9, align 8
  %vfn = getelementptr inbounds i32 (%"class.std::__1::basic_filebuf"*)*, i32 (%"class.std::__1::basic_filebuf"*)** %vtable, i64 6
  %10 = load i32 (%"class.std::__1::basic_filebuf"*)*, i32 (%"class.std::__1::basic_filebuf"*)** %vfn, align 8
  %call6 = call i32 %10(%"class.std::__1::basic_filebuf"* %this1)
  %tobool7 = icmp ne i32 %call6, 0
  br i1 %tobool7, label %if.then8, label %if.end9

if.then8:                                         ; preds = %lor.lhs.false5, %land.lhs.true, %if.end
  store %"class.std::__1::fpos"* %retval, %"class.std::__1::fpos"** %this.addr.i20, align 8
  store i64 -1, i64* %__off.addr.i, align 8
  %this1.i21 = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i20, align 8
  %__st_.i = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i21, i32 0, i32 0
  %11 = bitcast %struct.__mbstate_t* %__st_.i to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 8, i32 8, i1 false) #1
  %__off_.i = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i21, i32 0, i32 1
  %12 = load i64, i64* %__off.addr.i, align 8
  store i64 %12, i64* %__off_.i, align 8
  br label %return

if.end9:                                          ; preds = %lor.lhs.false5
  %13 = load i32, i32* %__way.addr, align 4
  switch i32 %13, label %sw.default [
    i32 0, label %sw.bb
    i32 1, label %sw.bb10
    i32 2, label %sw.bb11
  ]

sw.bb:                                            ; preds = %if.end9
  store i32 0, i32* %__whence, align 4
  br label %sw.epilog

sw.bb10:                                          ; preds = %if.end9
  store i32 1, i32* %__whence, align 4
  br label %sw.epilog

sw.bb11:                                          ; preds = %if.end9
  store i32 2, i32* %__whence, align 4
  br label %sw.epilog

sw.default:                                       ; preds = %if.end9
  store %"class.std::__1::fpos"* %retval, %"class.std::__1::fpos"** %this.addr.i22, align 8
  store i64 -1, i64* %__off.addr.i23, align 8
  %this1.i24 = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i22, align 8
  %__st_.i25 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i24, i32 0, i32 0
  %14 = bitcast %struct.__mbstate_t* %__st_.i25 to i8*
  call void @llvm.memset.p0i8.i64(i8* %14, i8 0, i64 8, i32 8, i1 false) #1
  %__off_.i26 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i24, i32 0, i32 1
  %15 = load i64, i64* %__off.addr.i23, align 8
  store i64 %15, i64* %__off_.i26, align 8
  br label %return

sw.epilog:                                        ; preds = %sw.bb11, %sw.bb10, %sw.bb
  %__file_12 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %16 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_12, align 8
  %17 = load i32, i32* %__width, align 4
  %cmp13 = icmp sgt i32 %17, 0
  br i1 %cmp13, label %cond.true, label %cond.false

cond.true:                                        ; preds = %sw.epilog
  %18 = load i32, i32* %__width, align 4
  %conv = sext i32 %18 to i64
  %19 = load i64, i64* %__off.addr, align 8
  %mul = mul nsw i64 %conv, %19
  br label %cond.end

cond.false:                                       ; preds = %sw.epilog
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i64 [ %mul, %cond.true ], [ 0, %cond.false ]
  %20 = load i32, i32* %__whence, align 4
  %call14 = call i32 @fseeko(%struct._IO_FILE* %16, i64 %cond, i32 %20)
  %tobool15 = icmp ne i32 %call14, 0
  br i1 %tobool15, label %if.then16, label %if.end17

if.then16:                                        ; preds = %cond.end
  store %"class.std::__1::fpos"* %retval, %"class.std::__1::fpos"** %this.addr.i27, align 8
  store i64 -1, i64* %__off.addr.i28, align 8
  %this1.i29 = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i27, align 8
  %__st_.i30 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i29, i32 0, i32 0
  %21 = bitcast %struct.__mbstate_t* %__st_.i30 to i8*
  call void @llvm.memset.p0i8.i64(i8* %21, i8 0, i64 8, i32 8, i1 false) #1
  %__off_.i31 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i29, i32 0, i32 1
  %22 = load i64, i64* %__off.addr.i28, align 8
  store i64 %22, i64* %__off_.i31, align 8
  br label %return

if.end17:                                         ; preds = %cond.end
  %__file_18 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %23 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_18, align 8
  %call19 = call i64 @ftello(%struct._IO_FILE* %23)
  store %"class.std::__1::fpos"* %__r, %"class.std::__1::fpos"** %this.addr.i35, align 8
  store i64 %call19, i64* %__off.addr.i36, align 8
  %this1.i37 = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i35, align 8
  %__st_.i38 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i37, i32 0, i32 0
  %24 = bitcast %struct.__mbstate_t* %__st_.i38 to i8*
  call void @llvm.memset.p0i8.i64(i8* %24, i8 0, i64 8, i32 8, i1 false) #1
  %__off_.i39 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i37, i32 0, i32 1
  %25 = load i64, i64* %__off.addr.i36, align 8
  store i64 %25, i64* %__off_.i39, align 8
  %__st_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 10
  %26 = bitcast %struct.__mbstate_t* %agg.tmp to i8*
  %27 = bitcast %struct.__mbstate_t* %__st_ to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %26, i8* %27, i64 8, i32 4, i1 false)
  %28 = bitcast %struct.__mbstate_t* %agg.tmp to i64*
  %29 = load i64, i64* %28, align 4
  %30 = bitcast %struct.__mbstate_t* %__st.i to i64*
  store i64 %29, i64* %30, align 4
  store %"class.std::__1::fpos"* %__r, %"class.std::__1::fpos"** %this.addr.i32, align 8
  %this1.i33 = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i32, align 8
  %__st_.i34 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i33, i32 0, i32 0
  %31 = bitcast %struct.__mbstate_t* %__st_.i34 to i8*
  %32 = bitcast %struct.__mbstate_t* %__st.i to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %31, i8* %32, i64 8, i32 4, i1 false) #1
  %33 = bitcast %"class.std::__1::fpos"* %retval to i8*
  %34 = bitcast %"class.std::__1::fpos"* %__r to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %33, i8* %34, i64 16, i32 8, i1 false)
  br label %return

return:                                           ; preds = %if.end17, %if.then16, %sw.default, %if.then8
  %35 = bitcast %"class.std::__1::fpos"* %retval to { i64, i64 }*
  %36 = load { i64, i64 }, { i64, i64 }* %35, align 8
  ret { i64, i64 } %36
}

; Function Attrs: uwtable
define linkonce_odr { i64, i64 } @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE7seekposENS_4fposI11__mbstate_tEEj(%"class.std::__1::basic_filebuf"* %this, i64 %__sp.coerce0, i64 %__sp.coerce1, i32) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr.i17 = alloca %"class.std::__1::fpos"*, align 8
  %this.addr.i12 = alloca %"class.std::__1::fpos"*, align 8
  %__off.addr.i13 = alloca i64, align 8
  %retval.i = alloca %struct.__mbstate_t, align 4
  %this.addr.i9 = alloca %"class.std::__1::fpos"*, align 8
  %this.addr.i = alloca %"class.std::__1::fpos"*, align 8
  %__off.addr.i = alloca i64, align 8
  %retval = alloca %"class.std::__1::fpos", align 8
  %__sp = alloca %"class.std::__1::fpos", align 8
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %.addr = alloca i32, align 4
  %ref.tmp = alloca %struct.__mbstate_t, align 4
  %1 = bitcast %"class.std::__1::fpos"* %__sp to { i64, i64 }*
  %2 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %1, i32 0, i32 0
  store i64 %__sp.coerce0, i64* %2, align 8
  %3 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %1, i32 0, i32 1
  store i64 %__sp.coerce1, i64* %3, align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store i32 %0, i32* %.addr, align 4
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_, align 8
  %cmp = icmp eq %struct._IO_FILE* %4, null
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %5 = bitcast %"class.std::__1::basic_filebuf"* %this1 to i32 (%"class.std::__1::basic_filebuf"*)***
  %vtable = load i32 (%"class.std::__1::basic_filebuf"*)**, i32 (%"class.std::__1::basic_filebuf"*)*** %5, align 8
  %vfn = getelementptr inbounds i32 (%"class.std::__1::basic_filebuf"*)*, i32 (%"class.std::__1::basic_filebuf"*)** %vtable, i64 6
  %6 = load i32 (%"class.std::__1::basic_filebuf"*)*, i32 (%"class.std::__1::basic_filebuf"*)** %vfn, align 8
  %call = call i32 %6(%"class.std::__1::basic_filebuf"* %this1)
  %tobool = icmp ne i32 %call, 0
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  store %"class.std::__1::fpos"* %retval, %"class.std::__1::fpos"** %this.addr.i, align 8
  store i64 -1, i64* %__off.addr.i, align 8
  %this1.i = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i, align 8
  %__st_.i = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i, i32 0, i32 0
  %7 = bitcast %struct.__mbstate_t* %__st_.i to i8*
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 8, i32 8, i1 false) #1
  %__off_.i = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i, i32 0, i32 1
  %8 = load i64, i64* %__off.addr.i, align 8
  store i64 %8, i64* %__off_.i, align 8
  br label %return

if.end:                                           ; preds = %lor.lhs.false
  %__file_2 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_2, align 8
  store %"class.std::__1::fpos"* %__sp, %"class.std::__1::fpos"** %this.addr.i17, align 8
  %this1.i18 = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i17, align 8
  %__off_.i19 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i18, i32 0, i32 1
  %10 = load i64, i64* %__off_.i19, align 8
  %call4 = call i32 @fseeko(%struct._IO_FILE* %9, i64 %10, i32 0)
  %tobool5 = icmp ne i32 %call4, 0
  br i1 %tobool5, label %if.then6, label %if.end7

if.then6:                                         ; preds = %if.end
  store %"class.std::__1::fpos"* %retval, %"class.std::__1::fpos"** %this.addr.i12, align 8
  store i64 -1, i64* %__off.addr.i13, align 8
  %this1.i14 = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i12, align 8
  %__st_.i15 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i14, i32 0, i32 0
  %11 = bitcast %struct.__mbstate_t* %__st_.i15 to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 8, i32 8, i1 false) #1
  %__off_.i16 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i14, i32 0, i32 1
  %12 = load i64, i64* %__off.addr.i13, align 8
  store i64 %12, i64* %__off_.i16, align 8
  br label %return

if.end7:                                          ; preds = %if.end
  %__st_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 10
  store %"class.std::__1::fpos"* %__sp, %"class.std::__1::fpos"** %this.addr.i9, align 8
  %this1.i10 = load %"class.std::__1::fpos"*, %"class.std::__1::fpos"** %this.addr.i9, align 8
  %__st_.i11 = getelementptr inbounds %"class.std::__1::fpos", %"class.std::__1::fpos"* %this1.i10, i32 0, i32 0
  %13 = bitcast %struct.__mbstate_t* %retval.i to i8*
  %14 = bitcast %struct.__mbstate_t* %__st_.i11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* %14, i64 8, i32 4, i1 false) #1
  %15 = bitcast %struct.__mbstate_t* %retval.i to i64*
  %16 = load i64, i64* %15, align 4
  %17 = bitcast %struct.__mbstate_t* %ref.tmp to i64*
  store i64 %16, i64* %17, align 4
  %18 = bitcast %struct.__mbstate_t* %__st_ to i8*
  %19 = bitcast %struct.__mbstate_t* %ref.tmp to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* %19, i64 8, i32 4, i1 false)
  %20 = bitcast %"class.std::__1::fpos"* %retval to i8*
  %21 = bitcast %"class.std::__1::fpos"* %__sp to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %20, i8* %21, i64 16, i32 8, i1 false)
  br label %return

return:                                           ; preds = %if.end7, %if.then6, %if.then
  %22 = bitcast %"class.std::__1::fpos"* %retval to { i64, i64 }*
  %23 = load { i64, i64 }, { i64, i64 }* %22, align 8
  ret { i64, i64 } %23
}

; Function Attrs: uwtable
define linkonce_odr i32 @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4syncEv(%"class.std::__1::basic_filebuf"* %this) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr.i135 = alloca %"class.std::__1::codecvt"*, align 8
  %this.addr.i132 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i129 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i126 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i123 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i120 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i117 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i114 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i108 = alloca %"class.std::__1::codecvt"*, align 8
  %__st.addr.i109 = alloca %struct.__mbstate_t*, align 8
  %__frm.addr.i = alloca i8*, align 8
  %__end.addr.i = alloca i8*, align 8
  %__mx.addr.i = alloca i64, align 8
  %this.addr.i105 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i = alloca i8*, align 8
  %__gnext.addr.i = alloca i8*, align 8
  %__gend.addr.i = alloca i8*, align 8
  %this.addr.i103 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i101 = alloca %"class.std::__1::codecvt"*, align 8
  %__st.addr.i = alloca %struct.__mbstate_t*, align 8
  %__to.addr.i = alloca i8*, align 8
  %__to_end.addr.i = alloca i8*, align 8
  %__to_nxt.addr.i = alloca i8**, align 8
  %this.addr.i99 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %retval = alloca i32, align 4
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__r = alloca i32, align 4
  %__extbe = alloca i8*, align 8
  %__nmemb = alloca i64, align 8
  %__c = alloca i64, align 8
  %__state = alloca %struct.__mbstate_t, align 4
  %__update_st = alloca i8, align 1
  %__width = alloca i32, align 4
  %__off = alloca i32, align 4
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_, align 8
  %cmp = icmp eq %struct._IO_FILE* %0, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 0, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %entry
  %__cv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %1 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_, align 8
  %tobool = icmp ne %"class.std::__1::codecvt"* %1, null
  br i1 %tobool, label %if.end3, label %if.then2

if.then2:                                         ; preds = %if.end
  %exception.i = call i8* @__cxa_allocate_exception(i64 8) #1
  %2 = bitcast i8* %exception.i to %"class.std::bad_cast"*
  call void @_ZNSt8bad_castC1Ev(%"class.std::bad_cast"* %2) #1
  call void @__cxa_throw(i8* %exception.i, i8* bitcast (i8** @_ZTISt8bad_cast to i8*), i8* bitcast (void (%"class.std::bad_cast"*)* @_ZNSt8bad_castD1Ev to i8*)) #15
  unreachable

_ZNSt3__116__throw_bad_castEv.exit:               ; No predecessors!
  unreachable

if.end3:                                          ; preds = %if.end
  %__cm_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 13
  %3 = load i32, i32* %__cm_, align 4
  %and = and i32 %3, 16
  %tobool4 = icmp ne i32 %and, 0
  br i1 %tobool4, label %if.then5, label %if.else

if.then5:                                         ; preds = %if.end3
  %4 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %4, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %__nout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 6
  %5 = load i8*, i8** %__nout_.i, align 8
  %6 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %6, %"class.std::__1::basic_streambuf"** %this.addr.i99, align 8
  %this1.i100 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i99, align 8
  %__bout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i100, i32 0, i32 5
  %7 = load i8*, i8** %__bout_.i, align 8
  %cmp7 = icmp ne i8* %5, %7
  br i1 %cmp7, label %if.then8, label %if.end15

if.then8:                                         ; preds = %if.then5
  %8 = bitcast %"class.std::__1::basic_filebuf"* %this1 to i32 (%"class.std::__1::basic_filebuf"*, i32)***
  %vtable = load i32 (%"class.std::__1::basic_filebuf"*, i32)**, i32 (%"class.std::__1::basic_filebuf"*, i32)*** %8, align 8
  %vfn = getelementptr inbounds i32 (%"class.std::__1::basic_filebuf"*, i32)*, i32 (%"class.std::__1::basic_filebuf"*, i32)** %vtable, i64 13
  %9 = load i32 (%"class.std::__1::basic_filebuf"*, i32)*, i32 (%"class.std::__1::basic_filebuf"*, i32)** %vfn, align 8
  %call9 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  %call10 = call i32 %9(%"class.std::__1::basic_filebuf"* %this1, i32 %call9)
  %call11 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  %cmp12 = icmp eq i32 %call10, %call11
  br i1 %cmp12, label %if.then13, label %if.end14

if.then13:                                        ; preds = %if.then8
  store i32 -1, i32* %retval, align 4
  br label %return

if.end14:                                         ; preds = %if.then8
  br label %if.end15

if.end15:                                         ; preds = %if.end14, %if.then5
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.end15
  %__cv_16 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %10 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_16, align 8
  %__st_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 10
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %11 = load i8*, i8** %__extbuf_, align 8
  %__extbuf_17 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %12 = load i8*, i8** %__extbuf_17, align 8
  %__ebs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %13 = load i64, i64* %__ebs_, align 8
  %add.ptr = getelementptr inbounds i8, i8* %12, i64 %13
  store %"class.std::__1::codecvt"* %10, %"class.std::__1::codecvt"** %this.addr.i101, align 8
  store %struct.__mbstate_t* %__st_, %struct.__mbstate_t** %__st.addr.i, align 8
  store i8* %11, i8** %__to.addr.i, align 8
  store i8* %add.ptr, i8** %__to_end.addr.i, align 8
  store i8** %__extbe, i8*** %__to_nxt.addr.i, align 8
  %this1.i102 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %this.addr.i101, align 8
  %14 = bitcast %"class.std::__1::codecvt"* %this1.i102 to i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**)***
  %vtable.i = load i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**)**, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**)*** %14, align 8
  %vfn.i = getelementptr inbounds i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**)*, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**)** %vtable.i, i64 5
  %15 = load i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**)*, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**)** %vfn.i, align 8
  %16 = load %struct.__mbstate_t*, %struct.__mbstate_t** %__st.addr.i, align 8
  %17 = load i8*, i8** %__to.addr.i, align 8
  %18 = load i8*, i8** %__to_end.addr.i, align 8
  %19 = load i8**, i8*** %__to_nxt.addr.i, align 8
  %call.i = call i32 %15(%"class.std::__1::codecvt"* %this1.i102, %struct.__mbstate_t* dereferenceable(8) %16, i8* %17, i8* %18, i8** dereferenceable(8) %19)
  store i32 %call.i, i32* %__r, align 4
  %20 = load i8*, i8** %__extbe, align 8
  %__extbuf_19 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %21 = load i8*, i8** %__extbuf_19, align 8
  %sub.ptr.lhs.cast = ptrtoint i8* %20 to i64
  %sub.ptr.rhs.cast = ptrtoint i8* %21 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  store i64 %sub.ptr.sub, i64* %__nmemb, align 8
  %__extbuf_20 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %22 = load i8*, i8** %__extbuf_20, align 8
  %23 = load i64, i64* %__nmemb, align 8
  %__file_21 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %24 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_21, align 8
  %call22 = call i64 @fwrite(i8* %22, i64 1, i64 %23, %struct._IO_FILE* %24)
  %25 = load i64, i64* %__nmemb, align 8
  %cmp23 = icmp ne i64 %call22, %25
  br i1 %cmp23, label %if.then24, label %if.end25

if.then24:                                        ; preds = %do.body
  store i32 -1, i32* %retval, align 4
  br label %return

if.end25:                                         ; preds = %do.body
  br label %do.cond

do.cond:                                          ; preds = %if.end25
  %26 = load i32, i32* %__r, align 4
  %cmp26 = icmp eq i32 %26, 1
  br i1 %cmp26, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  %27 = load i32, i32* %__r, align 4
  %cmp27 = icmp eq i32 %27, 2
  br i1 %cmp27, label %if.then28, label %if.end29

if.then28:                                        ; preds = %do.end
  store i32 -1, i32* %retval, align 4
  br label %return

if.end29:                                         ; preds = %do.end
  %__file_30 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %28 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_30, align 8
  %call31 = call i32 @fflush(%struct._IO_FILE* %28)
  %tobool32 = icmp ne i32 %call31, 0
  br i1 %tobool32, label %if.then33, label %if.end34

if.then33:                                        ; preds = %if.end29
  store i32 -1, i32* %retval, align 4
  br label %return

if.end34:                                         ; preds = %if.end29
  br label %if.end98

if.else:                                          ; preds = %if.end3
  %__cm_35 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 13
  %29 = load i32, i32* %__cm_35, align 4
  %and36 = and i32 %29, 8
  %tobool37 = icmp ne i32 %and36, 0
  br i1 %tobool37, label %if.then38, label %if.end97

if.then38:                                        ; preds = %if.else
  %__st_last_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 11
  %30 = bitcast %struct.__mbstate_t* %__state to i8*
  %31 = bitcast %struct.__mbstate_t* %__st_last_ to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %30, i8* %31, i64 8, i32 4, i1 false)
  store i8 0, i8* %__update_st, align 1
  %__always_noconv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %32 = load i8, i8* %__always_noconv_, align 2
  %tobool39 = trunc i8 %32 to i1
  br i1 %tobool39, label %if.then40, label %if.else46

if.then40:                                        ; preds = %if.then38
  %33 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %33, %"class.std::__1::basic_streambuf"** %this.addr.i103, align 8
  %this1.i104 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i103, align 8
  %__einp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i104, i32 0, i32 4
  %34 = load i8*, i8** %__einp_.i, align 8
  %35 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %35, %"class.std::__1::basic_streambuf"** %this.addr.i114, align 8
  %this1.i115 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i114, align 8
  %__ninp_.i116 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i115, i32 0, i32 3
  %36 = load i8*, i8** %__ninp_.i116, align 8
  %sub.ptr.lhs.cast43 = ptrtoint i8* %34 to i64
  %sub.ptr.rhs.cast44 = ptrtoint i8* %36 to i64
  %sub.ptr.sub45 = sub i64 %sub.ptr.lhs.cast43, %sub.ptr.rhs.cast44
  store i64 %sub.ptr.sub45, i64* %__c, align 8
  br label %if.end82

if.else46:                                        ; preds = %if.then38
  %__cv_47 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %37 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_47, align 8
  store %"class.std::__1::codecvt"* %37, %"class.std::__1::codecvt"** %this.addr.i135, align 8
  %this1.i136 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %this.addr.i135, align 8
  %38 = bitcast %"class.std::__1::codecvt"* %this1.i136 to i32 (%"class.std::__1::codecvt"*)***
  %vtable.i137 = load i32 (%"class.std::__1::codecvt"*)**, i32 (%"class.std::__1::codecvt"*)*** %38, align 8
  %vfn.i138 = getelementptr inbounds i32 (%"class.std::__1::codecvt"*)*, i32 (%"class.std::__1::codecvt"*)** %vtable.i137, i64 6
  %39 = load i32 (%"class.std::__1::codecvt"*)*, i32 (%"class.std::__1::codecvt"*)** %vfn.i138, align 8
  %call.i139 = call i32 %39(%"class.std::__1::codecvt"* %this1.i136) #1
  store i32 %call.i139, i32* %__width, align 4
  %__extbufend_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  %40 = load i8*, i8** %__extbufend_, align 8
  %__extbufnext_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %41 = load i8*, i8** %__extbufnext_, align 8
  %sub.ptr.lhs.cast49 = ptrtoint i8* %40 to i64
  %sub.ptr.rhs.cast50 = ptrtoint i8* %41 to i64
  %sub.ptr.sub51 = sub i64 %sub.ptr.lhs.cast49, %sub.ptr.rhs.cast50
  store i64 %sub.ptr.sub51, i64* %__c, align 8
  %42 = load i32, i32* %__width, align 4
  %cmp52 = icmp sgt i32 %42, 0
  br i1 %cmp52, label %if.then53, label %if.else59

if.then53:                                        ; preds = %if.else46
  %43 = load i32, i32* %__width, align 4
  %conv = sext i32 %43 to i64
  %44 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %44, %"class.std::__1::basic_streambuf"** %this.addr.i132, align 8
  %this1.i133 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i132, align 8
  %__einp_.i134 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i133, i32 0, i32 4
  %45 = load i8*, i8** %__einp_.i134, align 8
  %46 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %46, %"class.std::__1::basic_streambuf"** %this.addr.i129, align 8
  %this1.i130 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i129, align 8
  %__ninp_.i131 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i130, i32 0, i32 3
  %47 = load i8*, i8** %__ninp_.i131, align 8
  %sub.ptr.lhs.cast56 = ptrtoint i8* %45 to i64
  %sub.ptr.rhs.cast57 = ptrtoint i8* %47 to i64
  %sub.ptr.sub58 = sub i64 %sub.ptr.lhs.cast56, %sub.ptr.rhs.cast57
  %mul = mul nsw i64 %conv, %sub.ptr.sub58
  %48 = load i64, i64* %__c, align 8
  %add = add nsw i64 %48, %mul
  store i64 %add, i64* %__c, align 8
  br label %if.end81

if.else59:                                        ; preds = %if.else46
  %49 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %49, %"class.std::__1::basic_streambuf"** %this.addr.i126, align 8
  %this1.i127 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i126, align 8
  %__ninp_.i128 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i127, i32 0, i32 3
  %50 = load i8*, i8** %__ninp_.i128, align 8
  %51 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %51, %"class.std::__1::basic_streambuf"** %this.addr.i123, align 8
  %this1.i124 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i123, align 8
  %__einp_.i125 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i124, i32 0, i32 4
  %52 = load i8*, i8** %__einp_.i125, align 8
  %cmp62 = icmp ne i8* %50, %52
  br i1 %cmp62, label %if.then63, label %if.end80

if.then63:                                        ; preds = %if.else59
  %__cv_64 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %53 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_64, align 8
  %__extbuf_65 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %54 = load i8*, i8** %__extbuf_65, align 8
  %__extbufnext_66 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %55 = load i8*, i8** %__extbufnext_66, align 8
  %56 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %56, %"class.std::__1::basic_streambuf"** %this.addr.i120, align 8
  %this1.i121 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i120, align 8
  %__ninp_.i122 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i121, i32 0, i32 3
  %57 = load i8*, i8** %__ninp_.i122, align 8
  %58 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %58, %"class.std::__1::basic_streambuf"** %this.addr.i117, align 8
  %this1.i118 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i117, align 8
  %__binp_.i119 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i118, i32 0, i32 2
  %59 = load i8*, i8** %__binp_.i119, align 8
  %sub.ptr.lhs.cast69 = ptrtoint i8* %57 to i64
  %sub.ptr.rhs.cast70 = ptrtoint i8* %59 to i64
  %sub.ptr.sub71 = sub i64 %sub.ptr.lhs.cast69, %sub.ptr.rhs.cast70
  store %"class.std::__1::codecvt"* %53, %"class.std::__1::codecvt"** %this.addr.i108, align 8
  store %struct.__mbstate_t* %__state, %struct.__mbstate_t** %__st.addr.i109, align 8
  store i8* %54, i8** %__frm.addr.i, align 8
  store i8* %55, i8** %__end.addr.i, align 8
  store i64 %sub.ptr.sub71, i64* %__mx.addr.i, align 8
  %this1.i110 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %this.addr.i108, align 8
  %60 = bitcast %"class.std::__1::codecvt"* %this1.i110 to i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i64)***
  %vtable.i111 = load i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i64)**, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i64)*** %60, align 8
  %vfn.i112 = getelementptr inbounds i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i64)*, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i64)** %vtable.i111, i64 8
  %61 = load i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i64)*, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i64)** %vfn.i112, align 8
  %62 = load %struct.__mbstate_t*, %struct.__mbstate_t** %__st.addr.i109, align 8
  %63 = load i8*, i8** %__frm.addr.i, align 8
  %64 = load i8*, i8** %__end.addr.i, align 8
  %65 = load i64, i64* %__mx.addr.i, align 8
  %call.i113 = call i32 %61(%"class.std::__1::codecvt"* %this1.i110, %struct.__mbstate_t* dereferenceable(8) %62, i8* %63, i8* %64, i64 %65)
  store i32 %call.i113, i32* %__off, align 4
  %__extbufnext_73 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %66 = load i8*, i8** %__extbufnext_73, align 8
  %__extbuf_74 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %67 = load i8*, i8** %__extbuf_74, align 8
  %sub.ptr.lhs.cast75 = ptrtoint i8* %66 to i64
  %sub.ptr.rhs.cast76 = ptrtoint i8* %67 to i64
  %sub.ptr.sub77 = sub i64 %sub.ptr.lhs.cast75, %sub.ptr.rhs.cast76
  %68 = load i32, i32* %__off, align 4
  %conv78 = sext i32 %68 to i64
  %sub = sub nsw i64 %sub.ptr.sub77, %conv78
  %69 = load i64, i64* %__c, align 8
  %add79 = add nsw i64 %69, %sub
  store i64 %add79, i64* %__c, align 8
  store i8 1, i8* %__update_st, align 1
  br label %if.end80

if.end80:                                         ; preds = %if.then63, %if.else59
  br label %if.end81

if.end81:                                         ; preds = %if.end80, %if.then53
  br label %if.end82

if.end82:                                         ; preds = %if.end81, %if.then40
  %__file_83 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %70 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_83, align 8
  %71 = load i64, i64* %__c, align 8
  %sub84 = sub nsw i64 0, %71
  %call85 = call i32 @fseeko(%struct._IO_FILE* %70, i64 %sub84, i32 1)
  %tobool86 = icmp ne i32 %call85, 0
  br i1 %tobool86, label %if.then87, label %if.end88

if.then87:                                        ; preds = %if.end82
  store i32 -1, i32* %retval, align 4
  br label %return

if.end88:                                         ; preds = %if.end82
  %72 = load i8, i8* %__update_st, align 1
  %tobool89 = trunc i8 %72 to i1
  br i1 %tobool89, label %if.then90, label %if.end92

if.then90:                                        ; preds = %if.end88
  %__st_91 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 10
  %73 = bitcast %struct.__mbstate_t* %__st_91 to i8*
  %74 = bitcast %struct.__mbstate_t* %__state to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %73, i8* %74, i64 8, i32 4, i1 false)
  br label %if.end92

if.end92:                                         ; preds = %if.then90, %if.end88
  %__extbuf_93 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %75 = load i8*, i8** %__extbuf_93, align 8
  %__extbufend_94 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  store i8* %75, i8** %__extbufend_94, align 8
  %__extbufnext_95 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  store i8* %75, i8** %__extbufnext_95, align 8
  %76 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %76, %"class.std::__1::basic_streambuf"** %this.addr.i105, align 8
  store i8* null, i8** %__gbeg.addr.i, align 8
  store i8* null, i8** %__gnext.addr.i, align 8
  store i8* null, i8** %__gend.addr.i, align 8
  %this1.i106 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i105, align 8
  %77 = load i8*, i8** %__gbeg.addr.i, align 8
  %__binp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i106, i32 0, i32 2
  store i8* %77, i8** %__binp_.i, align 8
  %78 = load i8*, i8** %__gnext.addr.i, align 8
  %__ninp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i106, i32 0, i32 3
  store i8* %78, i8** %__ninp_.i, align 8
  %79 = load i8*, i8** %__gend.addr.i, align 8
  %__einp_.i107 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i106, i32 0, i32 4
  store i8* %79, i8** %__einp_.i107, align 8
  %__cm_96 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 13
  store i32 0, i32* %__cm_96, align 4
  br label %if.end97

if.end97:                                         ; preds = %if.end92, %if.else
  br label %if.end98

if.end98:                                         ; preds = %if.end97, %if.end34
  store i32 0, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end98, %if.then87, %if.then33, %if.then28, %if.then24, %if.then13, %if.then
  %80 = load i32, i32* %retval, align 4
  ret i32 %80
}

declare i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE9showmanycEv(%"class.std::__1::basic_streambuf"*) unnamed_addr #5

declare i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE6xsgetnEPcl(%"class.std::__1::basic_streambuf"*, i8*, i64) unnamed_addr #5

; Function Attrs: uwtable
define linkonce_odr i32 @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9underflowEv(%"class.std::__1::basic_filebuf"* %this) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr.i244 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i241 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i238 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i235 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i232 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i229 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i221 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i222 = alloca i8*, align 8
  %__gnext.addr.i223 = alloca i8*, align 8
  %__gend.addr.i224 = alloca i8*, align 8
  %this.addr.i218 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i215 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i.i.i200 = alloca %"struct.std::__1::__less.0"*, align 8
  %__x.addr.i.i.i201 = alloca i64*, align 8
  %__y.addr.i.i.i202 = alloca i64*, align 8
  %__comp.i.i203 = alloca %"struct.std::__1::__less.0", align 1
  %__a.addr.i.i204 = alloca i64*, align 8
  %__b.addr.i.i205 = alloca i64*, align 8
  %__a.addr.i206 = alloca i64*, align 8
  %__b.addr.i207 = alloca i64*, align 8
  %agg.tmp.i208 = alloca %"struct.std::__1::__less.0", align 1
  %this.addr.i197 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i194 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i191 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i188 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i185 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i.i.i = alloca %"struct.std::__1::__less.0"*, align 8
  %__x.addr.i.i.i = alloca i64*, align 8
  %__y.addr.i.i.i = alloca i64*, align 8
  %__comp.i.i = alloca %"struct.std::__1::__less.0", align 1
  %__a.addr.i.i = alloca i64*, align 8
  %__b.addr.i.i = alloca i64*, align 8
  %__a.addr.i = alloca i64*, align 8
  %__b.addr.i = alloca i64*, align 8
  %agg.tmp.i = alloca %"struct.std::__1::__less.0", align 1
  %this.addr.i183 = alloca %"class.std::__1::codecvt"*, align 8
  %__st.addr.i = alloca %struct.__mbstate_t*, align 8
  %__frm.addr.i = alloca i8*, align 8
  %__frm_end.addr.i = alloca i8*, align 8
  %__frm_nxt.addr.i = alloca i8**, align 8
  %__to.addr.i = alloca i8*, align 8
  %__to_end.addr.i = alloca i8*, align 8
  %__to_nxt.addr.i = alloca i8**, align 8
  %this.addr.i175 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i176 = alloca i8*, align 8
  %__gnext.addr.i177 = alloca i8*, align 8
  %__gend.addr.i178 = alloca i8*, align 8
  %this.addr.i172 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i169 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i166 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i163 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i160 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i152 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i153 = alloca i8*, align 8
  %__gnext.addr.i154 = alloca i8*, align 8
  %__gend.addr.i155 = alloca i8*, align 8
  %this.addr.i149 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i146 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i143 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i135 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i136 = alloca i8*, align 8
  %__gnext.addr.i137 = alloca i8*, align 8
  %__gend.addr.i138 = alloca i8*, align 8
  %this.addr.i132 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i129 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i = alloca i8*, align 8
  %__gnext.addr.i = alloca i8*, align 8
  %__gend.addr.i = alloca i8*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %retval = alloca i32, align 4
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__initial = alloca i8, align 1
  %__1buf = alloca i8, align 1
  %__unget_sz = alloca i64, align 8
  %ref.tmp = alloca i64, align 8
  %ref.tmp10 = alloca i64, align 8
  %__c = alloca i32, align 4
  %__nmemb = alloca i64, align 8
  %__nmemb68 = alloca i64, align 8
  %ref.tmp69 = alloca i64, align 8
  %ref.tmp71 = alloca i64, align 8
  %__r = alloca i32, align 4
  %__nr = alloca i64, align 8
  %__inext = alloca i8*, align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_, align 8
  %cmp = icmp eq %struct._IO_FILE* %0, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %entry
  %call2 = call zeroext i1 @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE11__read_modeEv(%"class.std::__1::basic_filebuf"* %this1)
  %frombool = zext i1 %call2 to i8
  store i8 %frombool, i8* %__initial, align 1
  %1 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %1, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %__ninp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 3
  %2 = load i8*, i8** %__ninp_.i, align 8
  %cmp4 = icmp eq i8* %2, null
  br i1 %cmp4, label %if.then5, label %if.end7

if.then5:                                         ; preds = %if.end
  %3 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %add.ptr = getelementptr inbounds i8, i8* %__1buf, i64 1
  %add.ptr6 = getelementptr inbounds i8, i8* %__1buf, i64 1
  store %"class.std::__1::basic_streambuf"* %3, %"class.std::__1::basic_streambuf"** %this.addr.i135, align 8
  store i8* %__1buf, i8** %__gbeg.addr.i136, align 8
  store i8* %add.ptr, i8** %__gnext.addr.i137, align 8
  store i8* %add.ptr6, i8** %__gend.addr.i138, align 8
  %this1.i139 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i135, align 8
  %4 = load i8*, i8** %__gbeg.addr.i136, align 8
  %__binp_.i140 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i139, i32 0, i32 2
  store i8* %4, i8** %__binp_.i140, align 8
  %5 = load i8*, i8** %__gnext.addr.i137, align 8
  %__ninp_.i141 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i139, i32 0, i32 3
  store i8* %5, i8** %__ninp_.i141, align 8
  %6 = load i8*, i8** %__gend.addr.i138, align 8
  %__einp_.i142 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i139, i32 0, i32 4
  store i8* %6, i8** %__einp_.i142, align 8
  br label %if.end7

if.end7:                                          ; preds = %if.then5, %if.end
  %7 = load i8, i8* %__initial, align 1
  %tobool = trunc i8 %7 to i1
  br i1 %tobool, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end7
  br label %cond.end

cond.false:                                       ; preds = %if.end7
  %8 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %8, %"class.std::__1::basic_streambuf"** %this.addr.i146, align 8
  %this1.i147 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i146, align 8
  %__einp_.i148 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i147, i32 0, i32 4
  %9 = load i8*, i8** %__einp_.i148, align 8
  %10 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %10, %"class.std::__1::basic_streambuf"** %this.addr.i169, align 8
  %this1.i170 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i169, align 8
  %__binp_.i171 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i170, i32 0, i32 2
  %11 = load i8*, i8** %__binp_.i171, align 8
  %sub.ptr.lhs.cast = ptrtoint i8* %9 to i64
  %sub.ptr.rhs.cast = ptrtoint i8* %11 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %div = sdiv i64 %sub.ptr.sub, 2
  store i64 %div, i64* %ref.tmp, align 8
  store i64 4, i64* %ref.tmp10, align 8
  store i64* %ref.tmp, i64** %__a.addr.i, align 8
  store i64* %ref.tmp10, i64** %__b.addr.i, align 8
  %12 = load i64*, i64** %__a.addr.i, align 8
  %13 = load i64*, i64** %__b.addr.i, align 8
  store i64* %12, i64** %__a.addr.i.i, align 8
  store i64* %13, i64** %__b.addr.i.i, align 8
  %14 = load i64*, i64** %__b.addr.i.i, align 8
  %15 = load i64*, i64** %__a.addr.i.i, align 8
  store %"struct.std::__1::__less.0"* %__comp.i.i, %"struct.std::__1::__less.0"** %this.addr.i.i.i, align 8
  store i64* %14, i64** %__x.addr.i.i.i, align 8
  store i64* %15, i64** %__y.addr.i.i.i, align 8
  %this1.i.i.i = load %"struct.std::__1::__less.0"*, %"struct.std::__1::__less.0"** %this.addr.i.i.i, align 8
  %16 = load i64*, i64** %__x.addr.i.i.i, align 8
  %17 = load i64, i64* %16, align 8
  %18 = load i64*, i64** %__y.addr.i.i.i, align 8
  %19 = load i64, i64* %18, align 8
  %cmp.i.i.i = icmp ult i64 %17, %19
  br i1 %cmp.i.i.i, label %cond.true.i.i, label %cond.false.i.i

cond.true.i.i:                                    ; preds = %cond.false
  %20 = load i64*, i64** %__b.addr.i.i, align 8
  br label %_ZNSt3__13minImEERKT_S3_S3_.exit

cond.false.i.i:                                   ; preds = %cond.false
  %21 = load i64*, i64** %__a.addr.i.i, align 8
  br label %_ZNSt3__13minImEERKT_S3_S3_.exit

_ZNSt3__13minImEERKT_S3_S3_.exit:                 ; preds = %cond.true.i.i, %cond.false.i.i
  %cond-lvalue.i.i = phi i64* [ %20, %cond.true.i.i ], [ %21, %cond.false.i.i ]
  %22 = load i64, i64* %cond-lvalue.i.i, align 8
  br label %cond.end

cond.end:                                         ; preds = %_ZNSt3__13minImEERKT_S3_S3_.exit, %cond.true
  %cond = phi i64 [ 0, %cond.true ], [ %22, %_ZNSt3__13minImEERKT_S3_S3_.exit ]
  store i64 %cond, i64* %__unget_sz, align 8
  %call12 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call12, i32* %__c, align 4
  %23 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %23, %"class.std::__1::basic_streambuf"** %this.addr.i191, align 8
  %this1.i192 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i191, align 8
  %__ninp_.i193 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i192, i32 0, i32 3
  %24 = load i8*, i8** %__ninp_.i193, align 8
  %25 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %25, %"class.std::__1::basic_streambuf"** %this.addr.i194, align 8
  %this1.i195 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i194, align 8
  %__einp_.i196 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i195, i32 0, i32 4
  %26 = load i8*, i8** %__einp_.i196, align 8
  %cmp15 = icmp eq i8* %24, %26
  br i1 %cmp15, label %if.then16, label %if.else121

if.then16:                                        ; preds = %cond.end
  %27 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %27, %"class.std::__1::basic_streambuf"** %this.addr.i197, align 8
  %this1.i198 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i197, align 8
  %__binp_.i199 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i198, i32 0, i32 2
  %28 = load i8*, i8** %__binp_.i199, align 8
  %29 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %29, %"class.std::__1::basic_streambuf"** %this.addr.i215, align 8
  %this1.i216 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i215, align 8
  %__einp_.i217 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i216, i32 0, i32 4
  %30 = load i8*, i8** %__einp_.i217, align 8
  %31 = load i64, i64* %__unget_sz, align 8
  %idx.neg = sub i64 0, %31
  %add.ptr19 = getelementptr inbounds i8, i8* %30, i64 %idx.neg
  %32 = load i64, i64* %__unget_sz, align 8
  %mul = mul i64 %32, 1
  call void @llvm.memmove.p0i8.p0i8.i64(i8* %28, i8* %add.ptr19, i64 %mul, i32 1, i1 false)
  %__always_noconv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %33 = load i8, i8* %__always_noconv_, align 2
  %tobool20 = trunc i8 %33 to i1
  br i1 %tobool20, label %if.then21, label %if.else

if.then21:                                        ; preds = %if.then16
  %34 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %34, %"class.std::__1::basic_streambuf"** %this.addr.i244, align 8
  %this1.i245 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i244, align 8
  %__einp_.i246 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i245, i32 0, i32 4
  %35 = load i8*, i8** %__einp_.i246, align 8
  %36 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %36, %"class.std::__1::basic_streambuf"** %this.addr.i241, align 8
  %this1.i242 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i241, align 8
  %__binp_.i243 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i242, i32 0, i32 2
  %37 = load i8*, i8** %__binp_.i243, align 8
  %sub.ptr.lhs.cast24 = ptrtoint i8* %35 to i64
  %sub.ptr.rhs.cast25 = ptrtoint i8* %37 to i64
  %sub.ptr.sub26 = sub i64 %sub.ptr.lhs.cast24, %sub.ptr.rhs.cast25
  %38 = load i64, i64* %__unget_sz, align 8
  %sub = sub i64 %sub.ptr.sub26, %38
  store i64 %sub, i64* %__nmemb, align 8
  %39 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %39, %"class.std::__1::basic_streambuf"** %this.addr.i238, align 8
  %this1.i239 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i238, align 8
  %__binp_.i240 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i239, i32 0, i32 2
  %40 = load i8*, i8** %__binp_.i240, align 8
  %41 = load i64, i64* %__unget_sz, align 8
  %add.ptr28 = getelementptr inbounds i8, i8* %40, i64 %41
  %42 = load i64, i64* %__nmemb, align 8
  %__file_29 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %43 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_29, align 8
  %call30 = call i64 @fread(i8* %add.ptr28, i64 1, i64 %42, %struct._IO_FILE* %43)
  store i64 %call30, i64* %__nmemb, align 8
  %44 = load i64, i64* %__nmemb, align 8
  %cmp31 = icmp ne i64 %44, 0
  br i1 %cmp31, label %if.then32, label %if.end41

if.then32:                                        ; preds = %if.then21
  %45 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %46 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %46, %"class.std::__1::basic_streambuf"** %this.addr.i235, align 8
  %this1.i236 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i235, align 8
  %__binp_.i237 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i236, i32 0, i32 2
  %47 = load i8*, i8** %__binp_.i237, align 8
  %48 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %48, %"class.std::__1::basic_streambuf"** %this.addr.i232, align 8
  %this1.i233 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i232, align 8
  %__binp_.i234 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i233, i32 0, i32 2
  %49 = load i8*, i8** %__binp_.i234, align 8
  %50 = load i64, i64* %__unget_sz, align 8
  %add.ptr35 = getelementptr inbounds i8, i8* %49, i64 %50
  %51 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %51, %"class.std::__1::basic_streambuf"** %this.addr.i229, align 8
  %this1.i230 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i229, align 8
  %__binp_.i231 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i230, i32 0, i32 2
  %52 = load i8*, i8** %__binp_.i231, align 8
  %53 = load i64, i64* %__unget_sz, align 8
  %add.ptr37 = getelementptr inbounds i8, i8* %52, i64 %53
  %54 = load i64, i64* %__nmemb, align 8
  %add.ptr38 = getelementptr inbounds i8, i8* %add.ptr37, i64 %54
  store %"class.std::__1::basic_streambuf"* %45, %"class.std::__1::basic_streambuf"** %this.addr.i221, align 8
  store i8* %47, i8** %__gbeg.addr.i222, align 8
  store i8* %add.ptr35, i8** %__gnext.addr.i223, align 8
  store i8* %add.ptr38, i8** %__gend.addr.i224, align 8
  %this1.i225 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i221, align 8
  %55 = load i8*, i8** %__gbeg.addr.i222, align 8
  %__binp_.i226 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i225, i32 0, i32 2
  store i8* %55, i8** %__binp_.i226, align 8
  %56 = load i8*, i8** %__gnext.addr.i223, align 8
  %__ninp_.i227 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i225, i32 0, i32 3
  store i8* %56, i8** %__ninp_.i227, align 8
  %57 = load i8*, i8** %__gend.addr.i224, align 8
  %__einp_.i228 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i225, i32 0, i32 4
  store i8* %57, i8** %__einp_.i228, align 8
  %58 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %58, %"class.std::__1::basic_streambuf"** %this.addr.i218, align 8
  %this1.i219 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i218, align 8
  %__ninp_.i220 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i219, i32 0, i32 3
  %59 = load i8*, i8** %__ninp_.i220, align 8
  %60 = load i8, i8* %59, align 1
  %call40 = call i32 @_ZNSt3__111char_traitsIcE11to_int_typeEc(i8 signext %60) #1
  store i32 %call40, i32* %__c, align 4
  br label %if.end41

if.end41:                                         ; preds = %if.then32, %if.then21
  br label %if.end120

if.else:                                          ; preds = %if.then16
  %__extbufend_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  %61 = load i8*, i8** %__extbufend_, align 8
  %__extbufnext_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %62 = load i8*, i8** %__extbufnext_, align 8
  %cmp42 = icmp ne i8* %61, %62
  br i1 %cmp42, label %if.then43, label %if.end50

if.then43:                                        ; preds = %if.else
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %63 = load i8*, i8** %__extbuf_, align 8
  %__extbufnext_44 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %64 = load i8*, i8** %__extbufnext_44, align 8
  %__extbufend_45 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  %65 = load i8*, i8** %__extbufend_45, align 8
  %__extbufnext_46 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %66 = load i8*, i8** %__extbufnext_46, align 8
  %sub.ptr.lhs.cast47 = ptrtoint i8* %65 to i64
  %sub.ptr.rhs.cast48 = ptrtoint i8* %66 to i64
  %sub.ptr.sub49 = sub i64 %sub.ptr.lhs.cast47, %sub.ptr.rhs.cast48
  call void @llvm.memmove.p0i8.p0i8.i64(i8* %63, i8* %64, i64 %sub.ptr.sub49, i32 1, i1 false)
  br label %if.end50

if.end50:                                         ; preds = %if.then43, %if.else
  %__extbuf_51 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %67 = load i8*, i8** %__extbuf_51, align 8
  %__extbufend_52 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  %68 = load i8*, i8** %__extbufend_52, align 8
  %__extbufnext_53 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %69 = load i8*, i8** %__extbufnext_53, align 8
  %sub.ptr.lhs.cast54 = ptrtoint i8* %68 to i64
  %sub.ptr.rhs.cast55 = ptrtoint i8* %69 to i64
  %sub.ptr.sub56 = sub i64 %sub.ptr.lhs.cast54, %sub.ptr.rhs.cast55
  %add.ptr57 = getelementptr inbounds i8, i8* %67, i64 %sub.ptr.sub56
  %__extbufnext_58 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  store i8* %add.ptr57, i8** %__extbufnext_58, align 8
  %__extbuf_59 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %70 = load i8*, i8** %__extbuf_59, align 8
  %__extbuf_60 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %71 = load i8*, i8** %__extbuf_60, align 8
  %__extbuf_min_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 4
  %arraydecay = getelementptr inbounds [8 x i8], [8 x i8]* %__extbuf_min_, i32 0, i32 0
  %cmp61 = icmp eq i8* %71, %arraydecay
  br i1 %cmp61, label %cond.true62, label %cond.false63

cond.true62:                                      ; preds = %if.end50
  br label %cond.end64

cond.false63:                                     ; preds = %if.end50
  %__ebs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %72 = load i64, i64* %__ebs_, align 8
  br label %cond.end64

cond.end64:                                       ; preds = %cond.false63, %cond.true62
  %cond65 = phi i64 [ 8, %cond.true62 ], [ %72, %cond.false63 ]
  %add.ptr66 = getelementptr inbounds i8, i8* %70, i64 %cond65
  %__extbufend_67 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  store i8* %add.ptr66, i8** %__extbufend_67, align 8
  %__ibs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %73 = load i64, i64* %__ibs_, align 8
  %74 = load i64, i64* %__unget_sz, align 8
  %sub70 = sub i64 %73, %74
  store i64 %sub70, i64* %ref.tmp69, align 8
  %__extbufend_72 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  %75 = load i8*, i8** %__extbufend_72, align 8
  %__extbufnext_73 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %76 = load i8*, i8** %__extbufnext_73, align 8
  %sub.ptr.lhs.cast74 = ptrtoint i8* %75 to i64
  %sub.ptr.rhs.cast75 = ptrtoint i8* %76 to i64
  %sub.ptr.sub76 = sub i64 %sub.ptr.lhs.cast74, %sub.ptr.rhs.cast75
  store i64 %sub.ptr.sub76, i64* %ref.tmp71, align 8
  store i64* %ref.tmp69, i64** %__a.addr.i206, align 8
  store i64* %ref.tmp71, i64** %__b.addr.i207, align 8
  %77 = load i64*, i64** %__a.addr.i206, align 8
  %78 = load i64*, i64** %__b.addr.i207, align 8
  store i64* %77, i64** %__a.addr.i.i204, align 8
  store i64* %78, i64** %__b.addr.i.i205, align 8
  %79 = load i64*, i64** %__b.addr.i.i205, align 8
  %80 = load i64*, i64** %__a.addr.i.i204, align 8
  store %"struct.std::__1::__less.0"* %__comp.i.i203, %"struct.std::__1::__less.0"** %this.addr.i.i.i200, align 8
  store i64* %79, i64** %__x.addr.i.i.i201, align 8
  store i64* %80, i64** %__y.addr.i.i.i202, align 8
  %this1.i.i.i209 = load %"struct.std::__1::__less.0"*, %"struct.std::__1::__less.0"** %this.addr.i.i.i200, align 8
  %81 = load i64*, i64** %__x.addr.i.i.i201, align 8
  %82 = load i64, i64* %81, align 8
  %83 = load i64*, i64** %__y.addr.i.i.i202, align 8
  %84 = load i64, i64* %83, align 8
  %cmp.i.i.i210 = icmp ult i64 %82, %84
  br i1 %cmp.i.i.i210, label %cond.true.i.i211, label %cond.false.i.i212

cond.true.i.i211:                                 ; preds = %cond.end64
  %85 = load i64*, i64** %__b.addr.i.i205, align 8
  br label %_ZNSt3__13minImEERKT_S3_S3_.exit214

cond.false.i.i212:                                ; preds = %cond.end64
  %86 = load i64*, i64** %__a.addr.i.i204, align 8
  br label %_ZNSt3__13minImEERKT_S3_S3_.exit214

_ZNSt3__13minImEERKT_S3_S3_.exit214:              ; preds = %cond.true.i.i211, %cond.false.i.i212
  %cond-lvalue.i.i213 = phi i64* [ %85, %cond.true.i.i211 ], [ %86, %cond.false.i.i212 ]
  %87 = load i64, i64* %cond-lvalue.i.i213, align 8
  store i64 %87, i64* %__nmemb68, align 8
  %__st_last_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 11
  %__st_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 10
  %88 = bitcast %struct.__mbstate_t* %__st_last_ to i8*
  %89 = bitcast %struct.__mbstate_t* %__st_ to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %88, i8* %89, i64 8, i32 8, i1 false)
  %__extbufnext_78 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %90 = load i8*, i8** %__extbufnext_78, align 8
  %91 = load i64, i64* %__nmemb68, align 8
  %__file_79 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %92 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_79, align 8
  %call80 = call i64 @fread(i8* %90, i64 1, i64 %91, %struct._IO_FILE* %92)
  store i64 %call80, i64* %__nr, align 8
  %93 = load i64, i64* %__nr, align 8
  %cmp81 = icmp ne i64 %93, 0
  br i1 %cmp81, label %if.then82, label %if.end119

if.then82:                                        ; preds = %_ZNSt3__13minImEERKT_S3_S3_.exit214
  %__cv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %94 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_, align 8
  %tobool83 = icmp ne %"class.std::__1::codecvt"* %94, null
  br i1 %tobool83, label %if.end85, label %if.then84

if.then84:                                        ; preds = %if.then82
  %exception.i = call i8* @__cxa_allocate_exception(i64 8) #1
  %95 = bitcast i8* %exception.i to %"class.std::bad_cast"*
  call void @_ZNSt8bad_castC1Ev(%"class.std::bad_cast"* %95) #1
  call void @__cxa_throw(i8* %exception.i, i8* bitcast (i8** @_ZTISt8bad_cast to i8*), i8* bitcast (void (%"class.std::bad_cast"*)* @_ZNSt8bad_castD1Ev to i8*)) #15
  unreachable

_ZNSt3__116__throw_bad_castEv.exit:               ; No predecessors!
  unreachable

if.end85:                                         ; preds = %if.then82
  %__extbufnext_86 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %96 = load i8*, i8** %__extbufnext_86, align 8
  %97 = load i64, i64* %__nr, align 8
  %add.ptr87 = getelementptr inbounds i8, i8* %96, i64 %97
  %__extbufend_88 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  store i8* %add.ptr87, i8** %__extbufend_88, align 8
  %__cv_89 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %98 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_89, align 8
  %__st_90 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 10
  %__extbuf_91 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %99 = load i8*, i8** %__extbuf_91, align 8
  %__extbufend_92 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  %100 = load i8*, i8** %__extbufend_92, align 8
  %__extbufnext_93 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 2
  %101 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %101, %"class.std::__1::basic_streambuf"** %this.addr.i188, align 8
  %this1.i189 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i188, align 8
  %__binp_.i190 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i189, i32 0, i32 2
  %102 = load i8*, i8** %__binp_.i190, align 8
  %103 = load i64, i64* %__unget_sz, align 8
  %add.ptr95 = getelementptr inbounds i8, i8* %102, i64 %103
  %104 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %104, %"class.std::__1::basic_streambuf"** %this.addr.i185, align 8
  %this1.i186 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i185, align 8
  %__binp_.i187 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i186, i32 0, i32 2
  %105 = load i8*, i8** %__binp_.i187, align 8
  %__ibs_97 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %106 = load i64, i64* %__ibs_97, align 8
  %add.ptr98 = getelementptr inbounds i8, i8* %105, i64 %106
  store %"class.std::__1::codecvt"* %98, %"class.std::__1::codecvt"** %this.addr.i183, align 8
  store %struct.__mbstate_t* %__st_90, %struct.__mbstate_t** %__st.addr.i, align 8
  store i8* %99, i8** %__frm.addr.i, align 8
  store i8* %100, i8** %__frm_end.addr.i, align 8
  store i8** %__extbufnext_93, i8*** %__frm_nxt.addr.i, align 8
  store i8* %add.ptr95, i8** %__to.addr.i, align 8
  store i8* %add.ptr98, i8** %__to_end.addr.i, align 8
  store i8** %__inext, i8*** %__to_nxt.addr.i, align 8
  %this1.i184 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %this.addr.i183, align 8
  %107 = bitcast %"class.std::__1::codecvt"* %this1.i184 to i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)***
  %vtable.i = load i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)**, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)*** %107, align 8
  %vfn.i = getelementptr inbounds i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)*, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)** %vtable.i, i64 4
  %108 = load i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)*, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)** %vfn.i, align 8
  %109 = load %struct.__mbstate_t*, %struct.__mbstate_t** %__st.addr.i, align 8
  %110 = load i8*, i8** %__frm.addr.i, align 8
  %111 = load i8*, i8** %__frm_end.addr.i, align 8
  %112 = load i8**, i8*** %__frm_nxt.addr.i, align 8
  %113 = load i8*, i8** %__to.addr.i, align 8
  %114 = load i8*, i8** %__to_end.addr.i, align 8
  %115 = load i8**, i8*** %__to_nxt.addr.i, align 8
  %call.i = call i32 %108(%"class.std::__1::codecvt"* %this1.i184, %struct.__mbstate_t* dereferenceable(8) %109, i8* %110, i8* %111, i8** dereferenceable(8) %112, i8* %113, i8* %114, i8** dereferenceable(8) %115)
  store i32 %call.i, i32* %__r, align 4
  %116 = load i32, i32* %__r, align 4
  %cmp100 = icmp eq i32 %116, 3
  br i1 %cmp100, label %if.then101, label %if.else107

if.then101:                                       ; preds = %if.end85
  %117 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %__extbuf_102 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %118 = load i8*, i8** %__extbuf_102, align 8
  %__extbuf_103 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %119 = load i8*, i8** %__extbuf_103, align 8
  %__extbufend_104 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 3
  %120 = load i8*, i8** %__extbufend_104, align 8
  store %"class.std::__1::basic_streambuf"* %117, %"class.std::__1::basic_streambuf"** %this.addr.i175, align 8
  store i8* %118, i8** %__gbeg.addr.i176, align 8
  store i8* %119, i8** %__gnext.addr.i177, align 8
  store i8* %120, i8** %__gend.addr.i178, align 8
  %this1.i179 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i175, align 8
  %121 = load i8*, i8** %__gbeg.addr.i176, align 8
  %__binp_.i180 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i179, i32 0, i32 2
  store i8* %121, i8** %__binp_.i180, align 8
  %122 = load i8*, i8** %__gnext.addr.i177, align 8
  %__ninp_.i181 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i179, i32 0, i32 3
  store i8* %122, i8** %__ninp_.i181, align 8
  %123 = load i8*, i8** %__gend.addr.i178, align 8
  %__einp_.i182 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i179, i32 0, i32 4
  store i8* %123, i8** %__einp_.i182, align 8
  %124 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %124, %"class.std::__1::basic_streambuf"** %this.addr.i172, align 8
  %this1.i173 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i172, align 8
  %__ninp_.i174 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i173, i32 0, i32 3
  %125 = load i8*, i8** %__ninp_.i174, align 8
  %126 = load i8, i8* %125, align 1
  %call106 = call i32 @_ZNSt3__111char_traitsIcE11to_int_typeEc(i8 signext %126) #1
  store i32 %call106, i32* %__c, align 4
  br label %if.end118

if.else107:                                       ; preds = %if.end85
  %127 = load i8*, i8** %__inext, align 8
  %128 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %128, %"class.std::__1::basic_streambuf"** %this.addr.i166, align 8
  %this1.i167 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i166, align 8
  %__binp_.i168 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i167, i32 0, i32 2
  %129 = load i8*, i8** %__binp_.i168, align 8
  %130 = load i64, i64* %__unget_sz, align 8
  %add.ptr109 = getelementptr inbounds i8, i8* %129, i64 %130
  %cmp110 = icmp ne i8* %127, %add.ptr109
  br i1 %cmp110, label %if.then111, label %if.end117

if.then111:                                       ; preds = %if.else107
  %131 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %132 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %132, %"class.std::__1::basic_streambuf"** %this.addr.i163, align 8
  %this1.i164 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i163, align 8
  %__binp_.i165 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i164, i32 0, i32 2
  %133 = load i8*, i8** %__binp_.i165, align 8
  %134 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %134, %"class.std::__1::basic_streambuf"** %this.addr.i160, align 8
  %this1.i161 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i160, align 8
  %__binp_.i162 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i161, i32 0, i32 2
  %135 = load i8*, i8** %__binp_.i162, align 8
  %136 = load i64, i64* %__unget_sz, align 8
  %add.ptr114 = getelementptr inbounds i8, i8* %135, i64 %136
  %137 = load i8*, i8** %__inext, align 8
  store %"class.std::__1::basic_streambuf"* %131, %"class.std::__1::basic_streambuf"** %this.addr.i152, align 8
  store i8* %133, i8** %__gbeg.addr.i153, align 8
  store i8* %add.ptr114, i8** %__gnext.addr.i154, align 8
  store i8* %137, i8** %__gend.addr.i155, align 8
  %this1.i156 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i152, align 8
  %138 = load i8*, i8** %__gbeg.addr.i153, align 8
  %__binp_.i157 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i156, i32 0, i32 2
  store i8* %138, i8** %__binp_.i157, align 8
  %139 = load i8*, i8** %__gnext.addr.i154, align 8
  %__ninp_.i158 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i156, i32 0, i32 3
  store i8* %139, i8** %__ninp_.i158, align 8
  %140 = load i8*, i8** %__gend.addr.i155, align 8
  %__einp_.i159 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i156, i32 0, i32 4
  store i8* %140, i8** %__einp_.i159, align 8
  %141 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %141, %"class.std::__1::basic_streambuf"** %this.addr.i149, align 8
  %this1.i150 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i149, align 8
  %__ninp_.i151 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i150, i32 0, i32 3
  %142 = load i8*, i8** %__ninp_.i151, align 8
  %143 = load i8, i8* %142, align 1
  %call116 = call i32 @_ZNSt3__111char_traitsIcE11to_int_typeEc(i8 signext %143) #1
  store i32 %call116, i32* %__c, align 4
  br label %if.end117

if.end117:                                        ; preds = %if.then111, %if.else107
  br label %if.end118

if.end118:                                        ; preds = %if.end117, %if.then101
  br label %if.end119

if.end119:                                        ; preds = %if.end118, %_ZNSt3__13minImEERKT_S3_S3_.exit214
  br label %if.end120

if.end120:                                        ; preds = %if.end119, %if.end41
  br label %if.end124

if.else121:                                       ; preds = %cond.end
  %144 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %144, %"class.std::__1::basic_streambuf"** %this.addr.i143, align 8
  %this1.i144 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i143, align 8
  %__ninp_.i145 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i144, i32 0, i32 3
  %145 = load i8*, i8** %__ninp_.i145, align 8
  %146 = load i8, i8* %145, align 1
  %call123 = call i32 @_ZNSt3__111char_traitsIcE11to_int_typeEc(i8 signext %146) #1
  store i32 %call123, i32* %__c, align 4
  br label %if.end124

if.end124:                                        ; preds = %if.else121, %if.end120
  %147 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %147, %"class.std::__1::basic_streambuf"** %this.addr.i132, align 8
  %this1.i133 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i132, align 8
  %__binp_.i134 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i133, i32 0, i32 2
  %148 = load i8*, i8** %__binp_.i134, align 8
  %cmp126 = icmp eq i8* %148, %__1buf
  br i1 %cmp126, label %if.then127, label %if.end128

if.then127:                                       ; preds = %if.end124
  %149 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %149, %"class.std::__1::basic_streambuf"** %this.addr.i129, align 8
  store i8* null, i8** %__gbeg.addr.i, align 8
  store i8* null, i8** %__gnext.addr.i, align 8
  store i8* null, i8** %__gend.addr.i, align 8
  %this1.i130 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i129, align 8
  %150 = load i8*, i8** %__gbeg.addr.i, align 8
  %__binp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i130, i32 0, i32 2
  store i8* %150, i8** %__binp_.i, align 8
  %151 = load i8*, i8** %__gnext.addr.i, align 8
  %__ninp_.i131 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i130, i32 0, i32 3
  store i8* %151, i8** %__ninp_.i131, align 8
  %152 = load i8*, i8** %__gend.addr.i, align 8
  %__einp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i130, i32 0, i32 4
  store i8* %152, i8** %__einp_.i, align 8
  br label %if.end128

if.end128:                                        ; preds = %if.then127, %if.end124
  %153 = load i32, i32* %__c, align 4
  store i32 %153, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end128, %if.then
  %154 = load i32, i32* %retval, align 4
  ret i32 %154
}

declare i32 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5uflowEv(%"class.std::__1::basic_streambuf"*) unnamed_addr #5

; Function Attrs: uwtable
define linkonce_odr i32 @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE9pbackfailEi(%"class.std::__1::basic_filebuf"* %this, i32 %__c) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr.i31 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i25 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__n.addr.i26 = alloca i32, align 4
  %this.addr.i22 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__n.addr.i = alloca i32, align 4
  %this.addr.i19 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i17 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %retval = alloca i32, align 4
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__c.addr = alloca i32, align 4
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store i32 %__c, i32* %__c.addr, align 4
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_, align 8
  %tobool = icmp ne %struct._IO_FILE* %0, null
  br i1 %tobool, label %land.lhs.true, label %if.end15

land.lhs.true:                                    ; preds = %entry
  %1 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %1, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %__binp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 2
  %2 = load i8*, i8** %__binp_.i, align 8
  %3 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %3, %"class.std::__1::basic_streambuf"** %this.addr.i17, align 8
  %this1.i18 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i17, align 8
  %__ninp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i18, i32 0, i32 3
  %4 = load i8*, i8** %__ninp_.i, align 8
  %cmp = icmp ult i8* %2, %4
  br i1 %cmp, label %if.then, label %if.end15

if.then:                                          ; preds = %land.lhs.true
  %5 = load i32, i32* %__c.addr, align 4
  %call3 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  %call4 = call zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 %5, i32 %call3) #1
  br i1 %call4, label %if.then5, label %if.end

if.then5:                                         ; preds = %if.then
  %6 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %6, %"class.std::__1::basic_streambuf"** %this.addr.i22, align 8
  store i32 -1, i32* %__n.addr.i, align 4
  %this1.i23 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i22, align 8
  %7 = load i32, i32* %__n.addr.i, align 4
  %__ninp_.i24 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i23, i32 0, i32 3
  %8 = load i8*, i8** %__ninp_.i24, align 8
  %idx.ext.i = sext i32 %7 to i64
  %add.ptr.i = getelementptr inbounds i8, i8* %8, i64 %idx.ext.i
  store i8* %add.ptr.i, i8** %__ninp_.i24, align 8
  %9 = load i32, i32* %__c.addr, align 4
  %call6 = call i32 @_ZNSt3__111char_traitsIcE7not_eofEi(i32 %9) #1
  store i32 %call6, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %if.then
  %__om_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 12
  %10 = load i32, i32* %__om_, align 8
  %and = and i32 %10, 16
  %tobool7 = icmp ne i32 %and, 0
  br i1 %tobool7, label %if.then11, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %11 = load i32, i32* %__c.addr, align 4
  %call8 = call signext i8 @_ZNSt3__111char_traitsIcE12to_char_typeEi(i32 %11) #1
  %12 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %12, %"class.std::__1::basic_streambuf"** %this.addr.i31, align 8
  %this1.i32 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i31, align 8
  %__ninp_.i33 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i32, i32 0, i32 3
  %13 = load i8*, i8** %__ninp_.i33, align 8
  %arrayidx = getelementptr inbounds i8, i8* %13, i64 -1
  %14 = load i8, i8* %arrayidx, align 1
  %call10 = call zeroext i1 @_ZNSt3__111char_traitsIcE2eqEcc(i8 signext %call8, i8 signext %14) #1
  br i1 %call10, label %if.then11, label %if.end14

if.then11:                                        ; preds = %lor.lhs.false, %if.end
  %15 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %15, %"class.std::__1::basic_streambuf"** %this.addr.i25, align 8
  store i32 -1, i32* %__n.addr.i26, align 4
  %this1.i27 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i25, align 8
  %16 = load i32, i32* %__n.addr.i26, align 4
  %__ninp_.i28 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i27, i32 0, i32 3
  %17 = load i8*, i8** %__ninp_.i28, align 8
  %idx.ext.i29 = sext i32 %16 to i64
  %add.ptr.i30 = getelementptr inbounds i8, i8* %17, i64 %idx.ext.i29
  store i8* %add.ptr.i30, i8** %__ninp_.i28, align 8
  %18 = load i32, i32* %__c.addr, align 4
  %call12 = call signext i8 @_ZNSt3__111char_traitsIcE12to_char_typeEi(i32 %18) #1
  %19 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %19, %"class.std::__1::basic_streambuf"** %this.addr.i19, align 8
  %this1.i20 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i19, align 8
  %__ninp_.i21 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i20, i32 0, i32 3
  %20 = load i8*, i8** %__ninp_.i21, align 8
  store i8 %call12, i8* %20, align 1
  %21 = load i32, i32* %__c.addr, align 4
  store i32 %21, i32* %retval, align 4
  br label %return

if.end14:                                         ; preds = %lor.lhs.false
  br label %if.end15

if.end15:                                         ; preds = %if.end14, %land.lhs.true, %entry
  %call16 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call16, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end15, %if.then11, %if.then5
  %22 = load i32, i32* %retval, align 4
  ret i32 %22
}

declare i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE6xsputnEPKcl(%"class.std::__1::basic_streambuf"*, i8*, i64) unnamed_addr #5

; Function Attrs: uwtable
define linkonce_odr i32 @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE8overflowEi(%"class.std::__1::basic_filebuf"* %this, i32 %__c) unnamed_addr #0 comdat align 2 {
entry:
  %this.addr.i167 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i164 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i161 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i158 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i155 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i152 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i149 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i147 = alloca %"class.std::__1::codecvt"*, align 8
  %__st.addr.i = alloca %struct.__mbstate_t*, align 8
  %__frm.addr.i = alloca i8*, align 8
  %__frm_end.addr.i = alloca i8*, align 8
  %__frm_nxt.addr.i = alloca i8**, align 8
  %__to.addr.i = alloca i8*, align 8
  %__to_end.addr.i = alloca i8*, align 8
  %__to_nxt.addr.i = alloca i8**, align 8
  %this.addr.i144 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i138 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__n.addr.i139 = alloca i32, align 4
  %this.addr.i135 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i132 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i129 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i126 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i119 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i120 = alloca i8*, align 8
  %__pend.addr.i121 = alloca i8*, align 8
  %this.addr.i116 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i109 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i110 = alloca i8*, align 8
  %__pend.addr.i111 = alloca i8*, align 8
  %this.addr.i106 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i103 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i100 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__n.addr.i = alloca i32, align 4
  %this.addr.i97 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i93 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i = alloca i8*, align 8
  %__pend.addr.i = alloca i8*, align 8
  %this.addr.i91 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %retval = alloca i32, align 4
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__c.addr = alloca i32, align 4
  %__1buf = alloca i8, align 1
  %__pb_save = alloca i8*, align 8
  %__epb_save = alloca i8*, align 8
  %__nmemb = alloca i64, align 8
  %__extbe = alloca i8*, align 8
  %__r = alloca i32, align 4
  %__e = alloca i8*, align 8
  %__nmemb45 = alloca i64, align 8
  %__nmemb62 = alloca i64, align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store i32 %__c, i32* %__c.addr, align 4
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_, align 8
  %cmp = icmp eq %struct._IO_FILE* %0, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call, i32* %retval, align 4
  br label %return

if.end:                                           ; preds = %entry
  call void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE12__write_modeEv(%"class.std::__1::basic_filebuf"* %this1)
  %1 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %1, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %__bout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 5
  %2 = load i8*, i8** %__bout_.i, align 8
  store i8* %2, i8** %__pb_save, align 8
  %3 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %3, %"class.std::__1::basic_streambuf"** %this.addr.i91, align 8
  %this1.i92 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i91, align 8
  %__eout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i92, i32 0, i32 7
  %4 = load i8*, i8** %__eout_.i, align 8
  store i8* %4, i8** %__epb_save, align 8
  %5 = load i32, i32* %__c.addr, align 4
  %call4 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  %call5 = call zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 %5, i32 %call4) #1
  br i1 %call5, label %if.end13, label %if.then6

if.then6:                                         ; preds = %if.end
  %6 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %6, %"class.std::__1::basic_streambuf"** %this.addr.i97, align 8
  %this1.i98 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i97, align 8
  %__nout_.i99 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i98, i32 0, i32 6
  %7 = load i8*, i8** %__nout_.i99, align 8
  %cmp8 = icmp eq i8* %7, null
  br i1 %cmp8, label %if.then9, label %if.end10

if.then9:                                         ; preds = %if.then6
  %8 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %add.ptr = getelementptr inbounds i8, i8* %__1buf, i64 1
  store %"class.std::__1::basic_streambuf"* %8, %"class.std::__1::basic_streambuf"** %this.addr.i119, align 8
  store i8* %__1buf, i8** %__pbeg.addr.i120, align 8
  store i8* %add.ptr, i8** %__pend.addr.i121, align 8
  %this1.i122 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i119, align 8
  %9 = load i8*, i8** %__pbeg.addr.i120, align 8
  %__nout_.i123 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i122, i32 0, i32 6
  store i8* %9, i8** %__nout_.i123, align 8
  %__bout_.i124 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i122, i32 0, i32 5
  store i8* %9, i8** %__bout_.i124, align 8
  %10 = load i8*, i8** %__pend.addr.i121, align 8
  %__eout_.i125 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i122, i32 0, i32 7
  store i8* %10, i8** %__eout_.i125, align 8
  br label %if.end10

if.end10:                                         ; preds = %if.then9, %if.then6
  %11 = load i32, i32* %__c.addr, align 4
  %call11 = call signext i8 @_ZNSt3__111char_traitsIcE12to_char_typeEi(i32 %11) #1
  %12 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %12, %"class.std::__1::basic_streambuf"** %this.addr.i126, align 8
  %this1.i127 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i126, align 8
  %__nout_.i128 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i127, i32 0, i32 6
  %13 = load i8*, i8** %__nout_.i128, align 8
  store i8 %call11, i8* %13, align 1
  %14 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %14, %"class.std::__1::basic_streambuf"** %this.addr.i138, align 8
  store i32 1, i32* %__n.addr.i139, align 4
  %this1.i140 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i138, align 8
  %15 = load i32, i32* %__n.addr.i139, align 4
  %__nout_.i141 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i140, i32 0, i32 6
  %16 = load i8*, i8** %__nout_.i141, align 8
  %idx.ext.i142 = sext i32 %15 to i64
  %add.ptr.i143 = getelementptr inbounds i8, i8* %16, i64 %idx.ext.i142
  store i8* %add.ptr.i143, i8** %__nout_.i141, align 8
  br label %if.end13

if.end13:                                         ; preds = %if.end10, %if.end
  %17 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %17, %"class.std::__1::basic_streambuf"** %this.addr.i149, align 8
  %this1.i150 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i149, align 8
  %__nout_.i151 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i150, i32 0, i32 6
  %18 = load i8*, i8** %__nout_.i151, align 8
  %19 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %19, %"class.std::__1::basic_streambuf"** %this.addr.i158, align 8
  %this1.i159 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i158, align 8
  %__bout_.i160 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i159, i32 0, i32 5
  %20 = load i8*, i8** %__bout_.i160, align 8
  %cmp16 = icmp ne i8* %18, %20
  br i1 %cmp16, label %if.then17, label %if.end89

if.then17:                                        ; preds = %if.end13
  %__always_noconv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %21 = load i8, i8* %__always_noconv_, align 2
  %tobool = trunc i8 %21 to i1
  br i1 %tobool, label %if.then18, label %if.else

if.then18:                                        ; preds = %if.then17
  %22 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %22, %"class.std::__1::basic_streambuf"** %this.addr.i161, align 8
  %this1.i162 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i161, align 8
  %__nout_.i163 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i162, i32 0, i32 6
  %23 = load i8*, i8** %__nout_.i163, align 8
  %24 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %24, %"class.std::__1::basic_streambuf"** %this.addr.i164, align 8
  %this1.i165 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i164, align 8
  %__bout_.i166 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i165, i32 0, i32 5
  %25 = load i8*, i8** %__bout_.i166, align 8
  %sub.ptr.lhs.cast = ptrtoint i8* %23 to i64
  %sub.ptr.rhs.cast = ptrtoint i8* %25 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  store i64 %sub.ptr.sub, i64* %__nmemb, align 8
  %26 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %26, %"class.std::__1::basic_streambuf"** %this.addr.i167, align 8
  %this1.i168 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i167, align 8
  %__bout_.i169 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i168, i32 0, i32 5
  %27 = load i8*, i8** %__bout_.i169, align 8
  %28 = load i64, i64* %__nmemb, align 8
  %__file_22 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %29 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_22, align 8
  %call23 = call i64 @fwrite(i8* %27, i64 1, i64 %28, %struct._IO_FILE* %29)
  %30 = load i64, i64* %__nmemb, align 8
  %cmp24 = icmp ne i64 %call23, %30
  br i1 %cmp24, label %if.then25, label %if.end27

if.then25:                                        ; preds = %if.then18
  %call26 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call26, i32* %retval, align 4
  br label %return

if.end27:                                         ; preds = %if.then18
  br label %if.end88

if.else:                                          ; preds = %if.then17
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %31 = load i8*, i8** %__extbuf_, align 8
  store i8* %31, i8** %__extbe, align 8
  br label %do.body

do.body:                                          ; preds = %do.cond, %if.else
  %__cv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %32 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_, align 8
  %tobool28 = icmp ne %"class.std::__1::codecvt"* %32, null
  br i1 %tobool28, label %if.end30, label %if.then29

if.then29:                                        ; preds = %do.body
  %exception.i = call i8* @__cxa_allocate_exception(i64 8) #1
  %33 = bitcast i8* %exception.i to %"class.std::bad_cast"*
  call void @_ZNSt8bad_castC1Ev(%"class.std::bad_cast"* %33) #1
  call void @__cxa_throw(i8* %exception.i, i8* bitcast (i8** @_ZTISt8bad_cast to i8*), i8* bitcast (void (%"class.std::bad_cast"*)* @_ZNSt8bad_castD1Ev to i8*)) #15
  unreachable

_ZNSt3__116__throw_bad_castEv.exit:               ; No predecessors!
  unreachable

if.end30:                                         ; preds = %do.body
  %__cv_31 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 9
  %34 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %__cv_31, align 8
  %__st_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 10
  %35 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %35, %"class.std::__1::basic_streambuf"** %this.addr.i155, align 8
  %this1.i156 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i155, align 8
  %__bout_.i157 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i156, i32 0, i32 5
  %36 = load i8*, i8** %__bout_.i157, align 8
  %37 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %37, %"class.std::__1::basic_streambuf"** %this.addr.i152, align 8
  %this1.i153 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i152, align 8
  %__nout_.i154 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i153, i32 0, i32 6
  %38 = load i8*, i8** %__nout_.i154, align 8
  %__extbuf_34 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %39 = load i8*, i8** %__extbuf_34, align 8
  %__extbuf_35 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %40 = load i8*, i8** %__extbuf_35, align 8
  %__ebs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %41 = load i64, i64* %__ebs_, align 8
  %add.ptr36 = getelementptr inbounds i8, i8* %40, i64 %41
  store %"class.std::__1::codecvt"* %34, %"class.std::__1::codecvt"** %this.addr.i147, align 8
  store %struct.__mbstate_t* %__st_, %struct.__mbstate_t** %__st.addr.i, align 8
  store i8* %36, i8** %__frm.addr.i, align 8
  store i8* %38, i8** %__frm_end.addr.i, align 8
  store i8** %__e, i8*** %__frm_nxt.addr.i, align 8
  store i8* %39, i8** %__to.addr.i, align 8
  store i8* %add.ptr36, i8** %__to_end.addr.i, align 8
  store i8** %__extbe, i8*** %__to_nxt.addr.i, align 8
  %this1.i148 = load %"class.std::__1::codecvt"*, %"class.std::__1::codecvt"** %this.addr.i147, align 8
  %42 = bitcast %"class.std::__1::codecvt"* %this1.i148 to i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)***
  %vtable.i = load i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)**, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)*** %42, align 8
  %vfn.i = getelementptr inbounds i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)*, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)** %vtable.i, i64 3
  %43 = load i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)*, i32 (%"class.std::__1::codecvt"*, %struct.__mbstate_t*, i8*, i8*, i8**, i8*, i8*, i8**)** %vfn.i, align 8
  %44 = load %struct.__mbstate_t*, %struct.__mbstate_t** %__st.addr.i, align 8
  %45 = load i8*, i8** %__frm.addr.i, align 8
  %46 = load i8*, i8** %__frm_end.addr.i, align 8
  %47 = load i8**, i8*** %__frm_nxt.addr.i, align 8
  %48 = load i8*, i8** %__to.addr.i, align 8
  %49 = load i8*, i8** %__to_end.addr.i, align 8
  %50 = load i8**, i8*** %__to_nxt.addr.i, align 8
  %call.i = call i32 %43(%"class.std::__1::codecvt"* %this1.i148, %struct.__mbstate_t* dereferenceable(8) %44, i8* %45, i8* %46, i8** dereferenceable(8) %47, i8* %48, i8* %49, i8** dereferenceable(8) %50)
  store i32 %call.i, i32* %__r, align 4
  %51 = load i8*, i8** %__e, align 8
  %52 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %52, %"class.std::__1::basic_streambuf"** %this.addr.i144, align 8
  %this1.i145 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i144, align 8
  %__bout_.i146 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i145, i32 0, i32 5
  %53 = load i8*, i8** %__bout_.i146, align 8
  %cmp39 = icmp eq i8* %51, %53
  br i1 %cmp39, label %if.then40, label %if.end42

if.then40:                                        ; preds = %if.end30
  %call41 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call41, i32* %retval, align 4
  br label %return

if.end42:                                         ; preds = %if.end30
  %54 = load i32, i32* %__r, align 4
  %cmp43 = icmp eq i32 %54, 3
  br i1 %cmp43, label %if.then44, label %if.else58

if.then44:                                        ; preds = %if.end42
  %55 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %55, %"class.std::__1::basic_streambuf"** %this.addr.i135, align 8
  %this1.i136 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i135, align 8
  %__nout_.i137 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i136, i32 0, i32 6
  %56 = load i8*, i8** %__nout_.i137, align 8
  %57 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %57, %"class.std::__1::basic_streambuf"** %this.addr.i132, align 8
  %this1.i133 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i132, align 8
  %__bout_.i134 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i133, i32 0, i32 5
  %58 = load i8*, i8** %__bout_.i134, align 8
  %sub.ptr.lhs.cast48 = ptrtoint i8* %56 to i64
  %sub.ptr.rhs.cast49 = ptrtoint i8* %58 to i64
  %sub.ptr.sub50 = sub i64 %sub.ptr.lhs.cast48, %sub.ptr.rhs.cast49
  store i64 %sub.ptr.sub50, i64* %__nmemb45, align 8
  %59 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %59, %"class.std::__1::basic_streambuf"** %this.addr.i129, align 8
  %this1.i130 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i129, align 8
  %__bout_.i131 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i130, i32 0, i32 5
  %60 = load i8*, i8** %__bout_.i131, align 8
  %61 = load i64, i64* %__nmemb45, align 8
  %__file_52 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %62 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_52, align 8
  %call53 = call i64 @fwrite(i8* %60, i64 1, i64 %61, %struct._IO_FILE* %62)
  %63 = load i64, i64* %__nmemb45, align 8
  %cmp54 = icmp ne i64 %call53, %63
  br i1 %cmp54, label %if.then55, label %if.end57

if.then55:                                        ; preds = %if.then44
  %call56 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call56, i32* %retval, align 4
  br label %return

if.end57:                                         ; preds = %if.then44
  br label %if.end86

if.else58:                                        ; preds = %if.end42
  %64 = load i32, i32* %__r, align 4
  %cmp59 = icmp eq i32 %64, 0
  br i1 %cmp59, label %if.then61, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.else58
  %65 = load i32, i32* %__r, align 4
  %cmp60 = icmp eq i32 %65, 1
  br i1 %cmp60, label %if.then61, label %if.else83

if.then61:                                        ; preds = %lor.lhs.false, %if.else58
  %66 = load i8*, i8** %__extbe, align 8
  %__extbuf_63 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %67 = load i8*, i8** %__extbuf_63, align 8
  %sub.ptr.lhs.cast64 = ptrtoint i8* %66 to i64
  %sub.ptr.rhs.cast65 = ptrtoint i8* %67 to i64
  %sub.ptr.sub66 = sub i64 %sub.ptr.lhs.cast64, %sub.ptr.rhs.cast65
  store i64 %sub.ptr.sub66, i64* %__nmemb62, align 8
  %__extbuf_67 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %68 = load i8*, i8** %__extbuf_67, align 8
  %69 = load i64, i64* %__nmemb62, align 8
  %__file_68 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %70 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_68, align 8
  %call69 = call i64 @fwrite(i8* %68, i64 1, i64 %69, %struct._IO_FILE* %70)
  %71 = load i64, i64* %__nmemb62, align 8
  %cmp70 = icmp ne i64 %call69, %71
  br i1 %cmp70, label %if.then71, label %if.end73

if.then71:                                        ; preds = %if.then61
  %call72 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call72, i32* %retval, align 4
  br label %return

if.end73:                                         ; preds = %if.then61
  %72 = load i32, i32* %__r, align 4
  %cmp74 = icmp eq i32 %72, 1
  br i1 %cmp74, label %if.then75, label %if.end82

if.then75:                                        ; preds = %if.end73
  %73 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %74 = load i8*, i8** %__e, align 8
  %75 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %75, %"class.std::__1::basic_streambuf"** %this.addr.i116, align 8
  %this1.i117 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i116, align 8
  %__nout_.i118 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i117, i32 0, i32 6
  %76 = load i8*, i8** %__nout_.i118, align 8
  store %"class.std::__1::basic_streambuf"* %73, %"class.std::__1::basic_streambuf"** %this.addr.i109, align 8
  store i8* %74, i8** %__pbeg.addr.i110, align 8
  store i8* %76, i8** %__pend.addr.i111, align 8
  %this1.i112 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i109, align 8
  %77 = load i8*, i8** %__pbeg.addr.i110, align 8
  %__nout_.i113 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i112, i32 0, i32 6
  store i8* %77, i8** %__nout_.i113, align 8
  %__bout_.i114 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i112, i32 0, i32 5
  store i8* %77, i8** %__bout_.i114, align 8
  %78 = load i8*, i8** %__pend.addr.i111, align 8
  %__eout_.i115 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i112, i32 0, i32 7
  store i8* %78, i8** %__eout_.i115, align 8
  %79 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %80 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %80, %"class.std::__1::basic_streambuf"** %this.addr.i106, align 8
  %this1.i107 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i106, align 8
  %__eout_.i108 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i107, i32 0, i32 7
  %81 = load i8*, i8** %__eout_.i108, align 8
  %82 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %82, %"class.std::__1::basic_streambuf"** %this.addr.i103, align 8
  %this1.i104 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i103, align 8
  %__bout_.i105 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i104, i32 0, i32 5
  %83 = load i8*, i8** %__bout_.i105, align 8
  %sub.ptr.lhs.cast79 = ptrtoint i8* %81 to i64
  %sub.ptr.rhs.cast80 = ptrtoint i8* %83 to i64
  %sub.ptr.sub81 = sub i64 %sub.ptr.lhs.cast79, %sub.ptr.rhs.cast80
  %conv = trunc i64 %sub.ptr.sub81 to i32
  store %"class.std::__1::basic_streambuf"* %79, %"class.std::__1::basic_streambuf"** %this.addr.i100, align 8
  store i32 %conv, i32* %__n.addr.i, align 4
  %this1.i101 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i100, align 8
  %84 = load i32, i32* %__n.addr.i, align 4
  %__nout_.i102 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i101, i32 0, i32 6
  %85 = load i8*, i8** %__nout_.i102, align 8
  %idx.ext.i = sext i32 %84 to i64
  %add.ptr.i = getelementptr inbounds i8, i8* %85, i64 %idx.ext.i
  store i8* %add.ptr.i, i8** %__nout_.i102, align 8
  br label %if.end82

if.end82:                                         ; preds = %if.then75, %if.end73
  br label %if.end85

if.else83:                                        ; preds = %lor.lhs.false
  %call84 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  store i32 %call84, i32* %retval, align 4
  br label %return

if.end85:                                         ; preds = %if.end82
  br label %if.end86

if.end86:                                         ; preds = %if.end85, %if.end57
  br label %do.cond

do.cond:                                          ; preds = %if.end86
  %86 = load i32, i32* %__r, align 4
  %cmp87 = icmp eq i32 %86, 1
  br i1 %cmp87, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  br label %if.end88

if.end88:                                         ; preds = %do.end, %if.end27
  %87 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %88 = load i8*, i8** %__pb_save, align 8
  %89 = load i8*, i8** %__epb_save, align 8
  store %"class.std::__1::basic_streambuf"* %87, %"class.std::__1::basic_streambuf"** %this.addr.i93, align 8
  store i8* %88, i8** %__pbeg.addr.i, align 8
  store i8* %89, i8** %__pend.addr.i, align 8
  %this1.i94 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i93, align 8
  %90 = load i8*, i8** %__pbeg.addr.i, align 8
  %__nout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i94, i32 0, i32 6
  store i8* %90, i8** %__nout_.i, align 8
  %__bout_.i95 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i94, i32 0, i32 5
  store i8* %90, i8** %__bout_.i95, align 8
  %91 = load i8*, i8** %__pend.addr.i, align 8
  %__eout_.i96 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i94, i32 0, i32 7
  store i8* %91, i8** %__eout_.i96, align 8
  br label %if.end89

if.end89:                                         ; preds = %if.end88, %if.end13
  %92 = load i32, i32* %__c.addr, align 4
  %call90 = call i32 @_ZNSt3__111char_traitsIcE7not_eofEi(i32 %92) #1
  store i32 %call90, i32* %retval, align 4
  br label %return

return:                                           ; preds = %if.end89, %if.else83, %if.then71, %if.then55, %if.then40, %if.then25, %if.then
  %93 = load i32, i32* %retval, align 4
  ret i32 %93
}

declare zeroext i1 @_ZNKSt3__16locale9has_facetERNS0_2idE(%"class.std::__1::locale"*, %"class.std::__1::locale::id"* dereferenceable(16)) #5

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #7 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #1
  call void @_ZSt9terminatev() #12
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

; Function Attrs: nounwind
declare void @_ZNSt3__16localeC1ERKS0_(%"class.std::__1::locale"*, %"class.std::__1::locale"* dereferenceable(8)) unnamed_addr #3

declare %"class.std::__1::locale::facet"* @_ZNKSt3__16locale9use_facetERNS0_2idE(%"class.std::__1::locale"*, %"class.std::__1::locale::id"* dereferenceable(16)) #5

; Function Attrs: uwtable
define linkonce_odr %"class.std::__1::basic_filebuf"* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE5closeEv(%"class.std::__1::basic_filebuf"* %this) #0 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr.i.i4.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %this.addr.i5.i = alloca %"class.std::__1::__compressed_pair"*, align 8
  %this.addr.i.i.i49 = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %this.addr.i.i50 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %this.addr.i51 = alloca %"class.std::__1::unique_ptr"*, align 8
  %__t.i = alloca %struct._IO_FILE*, align 8
  %this.addr.i.i12.i.i19 = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %this.addr.i13.i.i20 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %this.addr.i.i7.i.i21 = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %this.addr.i8.i.i22 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %this.addr.i.i.i.i23 = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %this.addr.i.i.i24 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %this.addr.i.i25 = alloca %"class.std::__1::unique_ptr"*, align 8
  %__p.addr.i.i26 = alloca %struct._IO_FILE*, align 8
  %__tmp.i.i27 = alloca %struct._IO_FILE*, align 8
  %this.addr.i28 = alloca %"class.std::__1::unique_ptr"*, align 8
  %this.addr.i.i12.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %this.addr.i13.i.i = alloca %"class.std::__1::__compressed_pair"*, align 8
  %this.addr.i.i7.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %this.addr.i8.i.i = alloca %"class.std::__1::__compressed_pair"*, align 8
  %this.addr.i.i.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %this.addr.i.i.i13 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %this.addr.i.i14 = alloca %"class.std::__1::unique_ptr"*, align 8
  %__p.addr.i.i = alloca %struct._IO_FILE*, align 8
  %__tmp.i.i = alloca %struct._IO_FILE*, align 8
  %this.addr.i15 = alloca %"class.std::__1::unique_ptr"*, align 8
  %__t.addr.i3.i.i = alloca i32 (%struct._IO_FILE*)**, align 8
  %__t.addr.i3.i.i.i = alloca i32 (%struct._IO_FILE*)**, align 8
  %__t.addr.i.i.i.i = alloca %struct._IO_FILE**, align 8
  %this.addr.i.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp"*, align 8
  %__t1.addr.i.i.i = alloca %struct._IO_FILE*, align 8
  %__t2.addr.i.i.i = alloca i32 (%struct._IO_FILE*)*, align 8
  %__t.addr.i.i.i = alloca %struct._IO_FILE**, align 8
  %this.addr.i.i = alloca %"class.std::__1::__compressed_pair"*, align 8
  %__t1.addr.i.i = alloca %struct._IO_FILE*, align 8
  %__t2.addr.i.i = alloca i32 (%struct._IO_FILE*)*, align 8
  %__t.addr.i.i = alloca i32 (%struct._IO_FILE*)**, align 8
  %this.addr.i = alloca %"class.std::__1::unique_ptr"*, align 8
  %__p.addr.i = alloca %struct._IO_FILE*, align 8
  %__d.addr.i = alloca i32 (%struct._IO_FILE*)**, align 8
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__rt = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__h = alloca %"class.std::__1::unique_ptr", align 8
  %ref.tmp = alloca i32 (%struct._IO_FILE*)*, align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store %"class.std::__1::basic_filebuf"* null, %"class.std::__1::basic_filebuf"** %__rt, align 8
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_, align 8
  %tobool = icmp ne %struct._IO_FILE* %0, null
  br i1 %tobool, label %if.then, label %if.end11

if.then:                                          ; preds = %entry
  store %"class.std::__1::basic_filebuf"* %this1, %"class.std::__1::basic_filebuf"** %__rt, align 8
  %__file_2 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_2, align 8
  store i32 (%struct._IO_FILE*)* @fclose, i32 (%struct._IO_FILE*)** %ref.tmp, align 8
  store %"class.std::__1::unique_ptr"* %__h, %"class.std::__1::unique_ptr"** %this.addr.i, align 8
  store %struct._IO_FILE* %1, %struct._IO_FILE** %__p.addr.i, align 8
  store i32 (%struct._IO_FILE*)** %ref.tmp, i32 (%struct._IO_FILE*)*** %__d.addr.i, align 8
  %this1.i = load %"class.std::__1::unique_ptr"*, %"class.std::__1::unique_ptr"** %this.addr.i, align 8
  %__ptr_.i = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i, i32 0, i32 0
  %2 = load %struct._IO_FILE*, %struct._IO_FILE** %__p.addr.i, align 8
  %3 = load i32 (%struct._IO_FILE*)**, i32 (%struct._IO_FILE*)*** %__d.addr.i, align 8
  store i32 (%struct._IO_FILE*)** %3, i32 (%struct._IO_FILE*)*** %__t.addr.i.i, align 8
  %4 = load i32 (%struct._IO_FILE*)**, i32 (%struct._IO_FILE*)*** %__t.addr.i.i, align 8
  %5 = load i32 (%struct._IO_FILE*)*, i32 (%struct._IO_FILE*)** %4, align 8
  store %"class.std::__1::__compressed_pair"* %__ptr_.i, %"class.std::__1::__compressed_pair"** %this.addr.i.i, align 8
  store %struct._IO_FILE* %2, %struct._IO_FILE** %__t1.addr.i.i, align 8
  store i32 (%struct._IO_FILE*)* %5, i32 (%struct._IO_FILE*)** %__t2.addr.i.i, align 8
  %this1.i.i = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i.i, align 8
  %6 = bitcast %"class.std::__1::__compressed_pair"* %this1.i.i to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %struct._IO_FILE** %__t1.addr.i.i, %struct._IO_FILE*** %__t.addr.i.i.i, align 8
  %7 = load %struct._IO_FILE**, %struct._IO_FILE*** %__t.addr.i.i.i, align 8
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** %7, align 8
  store i32 (%struct._IO_FILE*)** %__t2.addr.i.i, i32 (%struct._IO_FILE*)*** %__t.addr.i3.i.i, align 8
  %9 = load i32 (%struct._IO_FILE*)**, i32 (%struct._IO_FILE*)*** %__t.addr.i3.i.i, align 8
  %10 = load i32 (%struct._IO_FILE*)*, i32 (%struct._IO_FILE*)** %9, align 8
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %6, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i.i, align 8
  store %struct._IO_FILE* %8, %struct._IO_FILE** %__t1.addr.i.i.i, align 8
  store i32 (%struct._IO_FILE*)* %10, i32 (%struct._IO_FILE*)** %__t2.addr.i.i.i, align 8
  %this1.i.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i.i, align 8
  %__first_.i.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i.i, i32 0, i32 0
  store %struct._IO_FILE** %__t1.addr.i.i.i, %struct._IO_FILE*** %__t.addr.i.i.i.i, align 8
  %11 = load %struct._IO_FILE**, %struct._IO_FILE*** %__t.addr.i.i.i.i, align 8
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** %11, align 8
  store %struct._IO_FILE* %12, %struct._IO_FILE** %__first_.i.i.i, align 8
  %__second_.i.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i.i, i32 0, i32 1
  store i32 (%struct._IO_FILE*)** %__t2.addr.i.i.i, i32 (%struct._IO_FILE*)*** %__t.addr.i3.i.i.i, align 8
  %13 = load i32 (%struct._IO_FILE*)**, i32 (%struct._IO_FILE*)*** %__t.addr.i3.i.i.i, align 8
  %14 = load i32 (%struct._IO_FILE*)*, i32 (%struct._IO_FILE*)** %13, align 8
  store i32 (%struct._IO_FILE*)* %14, i32 (%struct._IO_FILE*)** %__second_.i.i.i, align 8
  %15 = bitcast %"class.std::__1::basic_filebuf"* %this1 to i32 (%"class.std::__1::basic_filebuf"*)***
  %vtable = load i32 (%"class.std::__1::basic_filebuf"*)**, i32 (%"class.std::__1::basic_filebuf"*)*** %15, align 8
  %vfn = getelementptr inbounds i32 (%"class.std::__1::basic_filebuf"*)*, i32 (%"class.std::__1::basic_filebuf"*)** %vtable, i64 6
  %16 = load i32 (%"class.std::__1::basic_filebuf"*)*, i32 (%"class.std::__1::basic_filebuf"*)** %vfn, align 8
  %call = invoke i32 %16(%"class.std::__1::basic_filebuf"* %this1)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %if.then
  %tobool3 = icmp ne i32 %call, 0
  br i1 %tobool3, label %if.then4, label %if.end

if.then4:                                         ; preds = %invoke.cont
  store %"class.std::__1::basic_filebuf"* null, %"class.std::__1::basic_filebuf"** %__rt, align 8
  br label %if.end

lpad:                                             ; preds = %if.end, %if.then
  %17 = landingpad { i8*, i32 }
          cleanup
  %18 = extractvalue { i8*, i32 } %17, 0
  store i8* %18, i8** %exn.slot, align 8
  %19 = extractvalue { i8*, i32 } %17, 1
  store i32 %19, i32* %ehselector.slot, align 4
  store %"class.std::__1::unique_ptr"* %__h, %"class.std::__1::unique_ptr"** %this.addr.i28, align 8
  %this1.i29 = load %"class.std::__1::unique_ptr"*, %"class.std::__1::unique_ptr"** %this.addr.i28, align 8
  store %"class.std::__1::unique_ptr"* %this1.i29, %"class.std::__1::unique_ptr"** %this.addr.i.i25, align 8
  store %struct._IO_FILE* null, %struct._IO_FILE** %__p.addr.i.i26, align 8
  %this1.i.i30 = load %"class.std::__1::unique_ptr"*, %"class.std::__1::unique_ptr"** %this.addr.i.i25, align 8
  %__ptr_.i.i31 = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i.i30, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %__ptr_.i.i31, %"class.std::__1::__compressed_pair"** %this.addr.i.i.i24, align 8
  %this1.i.i.i32 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i.i.i24, align 8
  %20 = bitcast %"class.std::__1::__compressed_pair"* %this1.i.i.i32 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %20, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i.i.i23, align 8
  %this1.i.i.i.i33 = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i.i.i23, align 8
  %__first_.i.i.i.i34 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i.i.i33, i32 0, i32 0
  %21 = load %struct._IO_FILE*, %struct._IO_FILE** %__first_.i.i.i.i34, align 8
  store %struct._IO_FILE* %21, %struct._IO_FILE** %__tmp.i.i27, align 8
  %22 = load %struct._IO_FILE*, %struct._IO_FILE** %__p.addr.i.i26, align 8
  %__ptr_2.i.i35 = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i.i30, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %__ptr_2.i.i35, %"class.std::__1::__compressed_pair"** %this.addr.i8.i.i22, align 8
  %this1.i9.i.i36 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i8.i.i22, align 8
  %23 = bitcast %"class.std::__1::__compressed_pair"* %this1.i9.i.i36 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %23, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i7.i.i21, align 8
  %this1.i.i10.i.i37 = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i7.i.i21, align 8
  %__first_.i.i11.i.i38 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i10.i.i37, i32 0, i32 0
  store %struct._IO_FILE* %22, %struct._IO_FILE** %__first_.i.i11.i.i38, align 8
  %24 = load %struct._IO_FILE*, %struct._IO_FILE** %__tmp.i.i27, align 8
  %tobool.i.i39 = icmp ne %struct._IO_FILE* %24, null
  br i1 %tobool.i.i39, label %if.then.i.i45, label %_ZNSt3__110unique_ptrI8_IO_FILEPFiPS1_EED2Ev.exit48

if.then.i.i45:                                    ; preds = %lpad
  %__ptr_4.i.i40 = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i.i30, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %__ptr_4.i.i40, %"class.std::__1::__compressed_pair"** %this.addr.i13.i.i20, align 8
  %this1.i14.i.i41 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i13.i.i20, align 8
  %25 = bitcast %"class.std::__1::__compressed_pair"* %this1.i14.i.i41 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %25, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i12.i.i19, align 8
  %this1.i.i15.i.i42 = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i12.i.i19, align 8
  %__second_.i.i.i.i43 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i15.i.i42, i32 0, i32 1
  %26 = load i32 (%struct._IO_FILE*)*, i32 (%struct._IO_FILE*)** %__second_.i.i.i.i43, align 8
  %27 = load %struct._IO_FILE*, %struct._IO_FILE** %__tmp.i.i27, align 8
  %call6.i.i44 = invoke i32 %26(%struct._IO_FILE* %27)
          to label %invoke.cont.i.i46 unwind label %terminate.lpad.i.i47

invoke.cont.i.i46:                                ; preds = %if.then.i.i45
  br label %_ZNSt3__110unique_ptrI8_IO_FILEPFiPS1_EED2Ev.exit48

terminate.lpad.i.i47:                             ; preds = %if.then.i.i45
  %28 = landingpad { i8*, i32 }
          catch i8* null
  %29 = extractvalue { i8*, i32 } %28, 0
  call void @__clang_call_terminate(i8* %29) #12
  unreachable

_ZNSt3__110unique_ptrI8_IO_FILEPFiPS1_EED2Ev.exit48: ; preds = %lpad, %invoke.cont.i.i46
  br label %eh.resume

if.end:                                           ; preds = %if.then4, %invoke.cont
  store %"class.std::__1::unique_ptr"* %__h, %"class.std::__1::unique_ptr"** %this.addr.i51, align 8
  %this1.i52 = load %"class.std::__1::unique_ptr"*, %"class.std::__1::unique_ptr"** %this.addr.i51, align 8
  %__ptr_.i53 = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i52, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %__ptr_.i53, %"class.std::__1::__compressed_pair"** %this.addr.i.i50, align 8
  %this1.i.i54 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i.i50, align 8
  %30 = bitcast %"class.std::__1::__compressed_pair"* %this1.i.i54 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %30, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i.i49, align 8
  %this1.i.i.i55 = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i.i49, align 8
  %__first_.i.i.i56 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i.i55, i32 0, i32 0
  %31 = load %struct._IO_FILE*, %struct._IO_FILE** %__first_.i.i.i56, align 8
  store %struct._IO_FILE* %31, %struct._IO_FILE** %__t.i, align 8
  %__ptr_2.i = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i52, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %__ptr_2.i, %"class.std::__1::__compressed_pair"** %this.addr.i5.i, align 8
  %this1.i6.i = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i5.i, align 8
  %32 = bitcast %"class.std::__1::__compressed_pair"* %this1.i6.i to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %32, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i4.i, align 8
  %this1.i.i7.i = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i4.i, align 8
  %__first_.i.i8.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i7.i, i32 0, i32 0
  store %struct._IO_FILE* null, %struct._IO_FILE** %__first_.i.i8.i, align 8
  %33 = load %struct._IO_FILE*, %struct._IO_FILE** %__t.i, align 8
  %call7 = invoke i32 @fclose(%struct._IO_FILE* %33)
          to label %invoke.cont6 unwind label %lpad

invoke.cont6:                                     ; preds = %if.end
  %cmp = icmp eq i32 %call7, 0
  br i1 %cmp, label %if.then8, label %if.else

if.then8:                                         ; preds = %invoke.cont6
  %__file_9 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  store %struct._IO_FILE* null, %struct._IO_FILE** %__file_9, align 8
  br label %if.end10

if.else:                                          ; preds = %invoke.cont6
  store %"class.std::__1::basic_filebuf"* null, %"class.std::__1::basic_filebuf"** %__rt, align 8
  br label %if.end10

if.end10:                                         ; preds = %if.else, %if.then8
  store %"class.std::__1::unique_ptr"* %__h, %"class.std::__1::unique_ptr"** %this.addr.i15, align 8
  %this1.i16 = load %"class.std::__1::unique_ptr"*, %"class.std::__1::unique_ptr"** %this.addr.i15, align 8
  store %"class.std::__1::unique_ptr"* %this1.i16, %"class.std::__1::unique_ptr"** %this.addr.i.i14, align 8
  store %struct._IO_FILE* null, %struct._IO_FILE** %__p.addr.i.i, align 8
  %this1.i.i17 = load %"class.std::__1::unique_ptr"*, %"class.std::__1::unique_ptr"** %this.addr.i.i14, align 8
  %__ptr_.i.i = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i.i17, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %__ptr_.i.i, %"class.std::__1::__compressed_pair"** %this.addr.i.i.i13, align 8
  %this1.i.i.i18 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i.i.i13, align 8
  %34 = bitcast %"class.std::__1::__compressed_pair"* %this1.i.i.i18 to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %34, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i.i.i, align 8
  %this1.i.i.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i.i.i, align 8
  %__first_.i.i.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i.i.i, i32 0, i32 0
  %35 = load %struct._IO_FILE*, %struct._IO_FILE** %__first_.i.i.i.i, align 8
  store %struct._IO_FILE* %35, %struct._IO_FILE** %__tmp.i.i, align 8
  %36 = load %struct._IO_FILE*, %struct._IO_FILE** %__p.addr.i.i, align 8
  %__ptr_2.i.i = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i.i17, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %__ptr_2.i.i, %"class.std::__1::__compressed_pair"** %this.addr.i8.i.i, align 8
  %this1.i9.i.i = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i8.i.i, align 8
  %37 = bitcast %"class.std::__1::__compressed_pair"* %this1.i9.i.i to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %37, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i7.i.i, align 8
  %this1.i.i10.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i7.i.i, align 8
  %__first_.i.i11.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i10.i.i, i32 0, i32 0
  store %struct._IO_FILE* %36, %struct._IO_FILE** %__first_.i.i11.i.i, align 8
  %38 = load %struct._IO_FILE*, %struct._IO_FILE** %__tmp.i.i, align 8
  %tobool.i.i = icmp ne %struct._IO_FILE* %38, null
  br i1 %tobool.i.i, label %if.then.i.i, label %_ZNSt3__110unique_ptrI8_IO_FILEPFiPS1_EED2Ev.exit

if.then.i.i:                                      ; preds = %if.end10
  %__ptr_4.i.i = getelementptr inbounds %"class.std::__1::unique_ptr", %"class.std::__1::unique_ptr"* %this1.i.i17, i32 0, i32 0
  store %"class.std::__1::__compressed_pair"* %__ptr_4.i.i, %"class.std::__1::__compressed_pair"** %this.addr.i13.i.i, align 8
  %this1.i14.i.i = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %this.addr.i13.i.i, align 8
  %39 = bitcast %"class.std::__1::__compressed_pair"* %this1.i14.i.i to %"class.std::__1::__libcpp_compressed_pair_imp"*
  store %"class.std::__1::__libcpp_compressed_pair_imp"* %39, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i12.i.i, align 8
  %this1.i.i15.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp"*, %"class.std::__1::__libcpp_compressed_pair_imp"** %this.addr.i.i12.i.i, align 8
  %__second_.i.i.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp", %"class.std::__1::__libcpp_compressed_pair_imp"* %this1.i.i15.i.i, i32 0, i32 1
  %40 = load i32 (%struct._IO_FILE*)*, i32 (%struct._IO_FILE*)** %__second_.i.i.i.i, align 8
  %41 = load %struct._IO_FILE*, %struct._IO_FILE** %__tmp.i.i, align 8
  %call6.i.i = invoke i32 %40(%struct._IO_FILE* %41)
          to label %invoke.cont.i.i unwind label %terminate.lpad.i.i

invoke.cont.i.i:                                  ; preds = %if.then.i.i
  br label %_ZNSt3__110unique_ptrI8_IO_FILEPFiPS1_EED2Ev.exit

terminate.lpad.i.i:                               ; preds = %if.then.i.i
  %42 = landingpad { i8*, i32 }
          catch i8* null
  %43 = extractvalue { i8*, i32 } %42, 0
  call void @__clang_call_terminate(i8* %43) #12
  unreachable

_ZNSt3__110unique_ptrI8_IO_FILEPFiPS1_EED2Ev.exit: ; preds = %if.end10, %invoke.cont.i.i
  br label %if.end11

if.end11:                                         ; preds = %_ZNSt3__110unique_ptrI8_IO_FILEPFiPS1_EED2Ev.exit, %entry
  %44 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %__rt, align 8
  ret %"class.std::__1::basic_filebuf"* %44

eh.resume:                                        ; preds = %_ZNSt3__110unique_ptrI8_IO_FILEPFiPS1_EED2Ev.exit48
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val12 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val12
}

declare void @__cxa_end_catch()

; Function Attrs: nobuiltin nounwind
declare void @_ZdaPv(i8*) #8

declare i32 @fclose(%struct._IO_FILE*) #5

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #8

; Function Attrs: nobuiltin
declare noalias i8* @_Znam(i64) #9

declare i32 @fseeko(%struct._IO_FILE*, i64, i32) #5

declare i64 @ftello(%struct._IO_FILE*) #5

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #6

declare i8* @__cxa_allocate_exception(i64)

; Function Attrs: nounwind
declare void @_ZNSt8bad_castC1Ev(%"class.std::bad_cast"*) unnamed_addr #3

; Function Attrs: nounwind
declare void @_ZNSt8bad_castD1Ev(%"class.std::bad_cast"*) unnamed_addr #3

declare void @__cxa_throw(i8*, i8*, i8*)

declare i64 @fwrite(i8*, i64, i64, %struct._IO_FILE*) #5

declare i32 @fflush(%struct._IO_FILE*) #5

; Function Attrs: nounwind uwtable
define linkonce_odr zeroext i1 @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE11__read_modeEv(%"class.std::__1::basic_filebuf"* %this) #4 comdat align 2 {
entry:
  %this.addr.i17 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i18 = alloca i8*, align 8
  %__gnext.addr.i19 = alloca i8*, align 8
  %__gend.addr.i20 = alloca i8*, align 8
  %this.addr.i15 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i = alloca i8*, align 8
  %__gnext.addr.i = alloca i8*, align 8
  %__gend.addr.i = alloca i8*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i = alloca i8*, align 8
  %__pend.addr.i = alloca i8*, align 8
  %retval = alloca i1, align 1
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %__cm_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 13
  %0 = load i32, i32* %__cm_, align 4
  %and = and i32 %0, 8
  %tobool = icmp ne i32 %and, 0
  br i1 %tobool, label %if.end14, label %if.then

if.then:                                          ; preds = %entry
  %1 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %1, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  store i8* null, i8** %__pbeg.addr.i, align 8
  store i8* null, i8** %__pend.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %2 = load i8*, i8** %__pbeg.addr.i, align 8
  %__nout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 6
  store i8* %2, i8** %__nout_.i, align 8
  %__bout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 5
  store i8* %2, i8** %__bout_.i, align 8
  %3 = load i8*, i8** %__pend.addr.i, align 8
  %__eout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 7
  store i8* %3, i8** %__eout_.i, align 8
  %__always_noconv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %4 = load i8, i8* %__always_noconv_, align 2
  %tobool2 = trunc i8 %4 to i1
  br i1 %tobool2, label %if.then3, label %if.else

if.then3:                                         ; preds = %if.then
  %5 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %6 = load i8*, i8** %__extbuf_, align 8
  %__extbuf_4 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %7 = load i8*, i8** %__extbuf_4, align 8
  %__ebs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %8 = load i64, i64* %__ebs_, align 8
  %add.ptr = getelementptr inbounds i8, i8* %7, i64 %8
  %__extbuf_5 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %9 = load i8*, i8** %__extbuf_5, align 8
  %__ebs_6 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %10 = load i64, i64* %__ebs_6, align 8
  %add.ptr7 = getelementptr inbounds i8, i8* %9, i64 %10
  store %"class.std::__1::basic_streambuf"* %5, %"class.std::__1::basic_streambuf"** %this.addr.i17, align 8
  store i8* %6, i8** %__gbeg.addr.i18, align 8
  store i8* %add.ptr, i8** %__gnext.addr.i19, align 8
  store i8* %add.ptr7, i8** %__gend.addr.i20, align 8
  %this1.i21 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i17, align 8
  %11 = load i8*, i8** %__gbeg.addr.i18, align 8
  %__binp_.i22 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i21, i32 0, i32 2
  store i8* %11, i8** %__binp_.i22, align 8
  %12 = load i8*, i8** %__gnext.addr.i19, align 8
  %__ninp_.i23 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i21, i32 0, i32 3
  store i8* %12, i8** %__ninp_.i23, align 8
  %13 = load i8*, i8** %__gend.addr.i20, align 8
  %__einp_.i24 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i21, i32 0, i32 4
  store i8* %13, i8** %__einp_.i24, align 8
  br label %if.end

if.else:                                          ; preds = %if.then
  %14 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %__intbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  %15 = load i8*, i8** %__intbuf_, align 8
  %__intbuf_8 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  %16 = load i8*, i8** %__intbuf_8, align 8
  %__ibs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %17 = load i64, i64* %__ibs_, align 8
  %add.ptr9 = getelementptr inbounds i8, i8* %16, i64 %17
  %__intbuf_10 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  %18 = load i8*, i8** %__intbuf_10, align 8
  %__ibs_11 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %19 = load i64, i64* %__ibs_11, align 8
  %add.ptr12 = getelementptr inbounds i8, i8* %18, i64 %19
  store %"class.std::__1::basic_streambuf"* %14, %"class.std::__1::basic_streambuf"** %this.addr.i15, align 8
  store i8* %15, i8** %__gbeg.addr.i, align 8
  store i8* %add.ptr9, i8** %__gnext.addr.i, align 8
  store i8* %add.ptr12, i8** %__gend.addr.i, align 8
  %this1.i16 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i15, align 8
  %20 = load i8*, i8** %__gbeg.addr.i, align 8
  %__binp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i16, i32 0, i32 2
  store i8* %20, i8** %__binp_.i, align 8
  %21 = load i8*, i8** %__gnext.addr.i, align 8
  %__ninp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i16, i32 0, i32 3
  store i8* %21, i8** %__ninp_.i, align 8
  %22 = load i8*, i8** %__gend.addr.i, align 8
  %__einp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i16, i32 0, i32 4
  store i8* %22, i8** %__einp_.i, align 8
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then3
  %__cm_13 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 13
  store i32 8, i32* %__cm_13, align 4
  store i1 true, i1* %retval, align 1
  br label %return

if.end14:                                         ; preds = %entry
  store i1 false, i1* %retval, align 1
  br label %return

return:                                           ; preds = %if.end14, %if.end
  %23 = load i1, i1* %retval, align 1
  ret i1 %23
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #6

declare i64 @fread(i8*, i64, i64, %struct._IO_FILE*) #5

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr i32 @_ZNSt3__111char_traitsIcE11to_int_typeEc(i8 signext %__c) #2 comdat align 2 {
entry:
  %__c.addr = alloca i8, align 1
  store i8 %__c, i8* %__c.addr, align 1
  %0 = load i8, i8* %__c.addr, align 1
  %conv = zext i8 %0 to i32
  ret i32 %conv
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 %__c1, i32 %__c2) #2 comdat align 2 {
entry:
  %__c1.addr = alloca i32, align 4
  %__c2.addr = alloca i32, align 4
  store i32 %__c1, i32* %__c1.addr, align 4
  store i32 %__c2, i32* %__c2.addr, align 4
  %0 = load i32, i32* %__c1.addr, align 4
  %1 = load i32, i32* %__c2.addr, align 4
  %cmp = icmp eq i32 %0, %1
  ret i1 %cmp
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr i32 @_ZNSt3__111char_traitsIcE7not_eofEi(i32 %__c) #2 comdat align 2 {
entry:
  %__c.addr = alloca i32, align 4
  store i32 %__c, i32* %__c.addr, align 4
  %0 = load i32, i32* %__c.addr, align 4
  %call = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  %call1 = call zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 %0, i32 %call) #1
  br i1 %call1, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %call2 = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  %neg = xor i32 %call2, -1
  br label %cond.end

cond.false:                                       ; preds = %entry
  %1 = load i32, i32* %__c.addr, align 4
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %neg, %cond.true ], [ %1, %cond.false ]
  ret i32 %cond
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr zeroext i1 @_ZNSt3__111char_traitsIcE2eqEcc(i8 signext %__c1, i8 signext %__c2) #2 comdat align 2 {
entry:
  %__c1.addr = alloca i8, align 1
  %__c2.addr = alloca i8, align 1
  store i8 %__c1, i8* %__c1.addr, align 1
  store i8 %__c2, i8* %__c2.addr, align 1
  %0 = load i8, i8* %__c1.addr, align 1
  %conv = sext i8 %0 to i32
  %1 = load i8, i8* %__c2.addr, align 1
  %conv1 = sext i8 %1 to i32
  %cmp = icmp eq i32 %conv, %conv1
  ret i1 %cmp
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr signext i8 @_ZNSt3__111char_traitsIcE12to_char_typeEi(i32 %__c) #2 comdat align 2 {
entry:
  %__c.addr = alloca i32, align 4
  store i32 %__c, i32* %__c.addr, align 4
  %0 = load i32, i32* %__c.addr, align 4
  %conv = trunc i32 %0 to i8
  ret i8 %conv
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE12__write_modeEv(%"class.std::__1::basic_filebuf"* %this) #4 comdat align 2 {
entry:
  %this.addr.i23 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i24 = alloca i8*, align 8
  %__pend.addr.i25 = alloca i8*, align 8
  %this.addr.i16 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i17 = alloca i8*, align 8
  %__pend.addr.i18 = alloca i8*, align 8
  %this.addr.i14 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__pbeg.addr.i = alloca i8*, align 8
  %__pend.addr.i = alloca i8*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__gbeg.addr.i = alloca i8*, align 8
  %__gnext.addr.i = alloca i8*, align 8
  %__gend.addr.i = alloca i8*, align 8
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  %__cm_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 13
  %0 = load i32, i32* %__cm_, align 4
  %and = and i32 %0, 16
  %tobool = icmp ne i32 %and, 0
  br i1 %tobool, label %if.end13, label %if.then

if.then:                                          ; preds = %entry
  %1 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %1, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  store i8* null, i8** %__gbeg.addr.i, align 8
  store i8* null, i8** %__gnext.addr.i, align 8
  store i8* null, i8** %__gend.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i, align 8
  %2 = load i8*, i8** %__gbeg.addr.i, align 8
  %__binp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 2
  store i8* %2, i8** %__binp_.i, align 8
  %3 = load i8*, i8** %__gnext.addr.i, align 8
  %__ninp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 3
  store i8* %3, i8** %__ninp_.i, align 8
  %4 = load i8*, i8** %__gend.addr.i, align 8
  %__einp_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i, i32 0, i32 4
  store i8* %4, i8** %__einp_.i, align 8
  %__ebs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %5 = load i64, i64* %__ebs_, align 8
  %cmp = icmp ugt i64 %5, 8
  br i1 %cmp, label %if.then2, label %if.else10

if.then2:                                         ; preds = %if.then
  %__always_noconv_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 16
  %6 = load i8, i8* %__always_noconv_, align 2
  %tobool3 = trunc i8 %6 to i1
  br i1 %tobool3, label %if.then4, label %if.else

if.then4:                                         ; preds = %if.then2
  %7 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %__extbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %8 = load i8*, i8** %__extbuf_, align 8
  %__extbuf_5 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 1
  %9 = load i8*, i8** %__extbuf_5, align 8
  %__ebs_6 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 5
  %10 = load i64, i64* %__ebs_6, align 8
  %sub = sub i64 %10, 1
  %add.ptr = getelementptr inbounds i8, i8* %9, i64 %sub
  store %"class.std::__1::basic_streambuf"* %7, %"class.std::__1::basic_streambuf"** %this.addr.i23, align 8
  store i8* %8, i8** %__pbeg.addr.i24, align 8
  store i8* %add.ptr, i8** %__pend.addr.i25, align 8
  %this1.i26 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i23, align 8
  %11 = load i8*, i8** %__pbeg.addr.i24, align 8
  %__nout_.i27 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i26, i32 0, i32 6
  store i8* %11, i8** %__nout_.i27, align 8
  %__bout_.i28 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i26, i32 0, i32 5
  store i8* %11, i8** %__bout_.i28, align 8
  %12 = load i8*, i8** %__pend.addr.i25, align 8
  %__eout_.i29 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i26, i32 0, i32 7
  store i8* %12, i8** %__eout_.i29, align 8
  br label %if.end

if.else:                                          ; preds = %if.then2
  %13 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  %__intbuf_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  %14 = load i8*, i8** %__intbuf_, align 8
  %__intbuf_7 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 6
  %15 = load i8*, i8** %__intbuf_7, align 8
  %__ibs_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 7
  %16 = load i64, i64* %__ibs_, align 8
  %sub8 = sub i64 %16, 1
  %add.ptr9 = getelementptr inbounds i8, i8* %15, i64 %sub8
  store %"class.std::__1::basic_streambuf"* %13, %"class.std::__1::basic_streambuf"** %this.addr.i16, align 8
  store i8* %14, i8** %__pbeg.addr.i17, align 8
  store i8* %add.ptr9, i8** %__pend.addr.i18, align 8
  %this1.i19 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i16, align 8
  %17 = load i8*, i8** %__pbeg.addr.i17, align 8
  %__nout_.i20 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i19, i32 0, i32 6
  store i8* %17, i8** %__nout_.i20, align 8
  %__bout_.i21 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i19, i32 0, i32 5
  store i8* %17, i8** %__bout_.i21, align 8
  %18 = load i8*, i8** %__pend.addr.i18, align 8
  %__eout_.i22 = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i19, i32 0, i32 7
  store i8* %18, i8** %__eout_.i22, align 8
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then4
  br label %if.end11

if.else10:                                        ; preds = %if.then
  %19 = bitcast %"class.std::__1::basic_filebuf"* %this1 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %19, %"class.std::__1::basic_streambuf"** %this.addr.i14, align 8
  store i8* null, i8** %__pbeg.addr.i, align 8
  store i8* null, i8** %__pend.addr.i, align 8
  %this1.i15 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i14, align 8
  %20 = load i8*, i8** %__pbeg.addr.i, align 8
  %__nout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i15, i32 0, i32 6
  store i8* %20, i8** %__nout_.i, align 8
  %__bout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i15, i32 0, i32 5
  store i8* %20, i8** %__bout_.i, align 8
  %21 = load i8*, i8** %__pend.addr.i, align 8
  %__eout_.i = getelementptr inbounds %"class.std::__1::basic_streambuf", %"class.std::__1::basic_streambuf"* %this1.i15, i32 0, i32 7
  store i8* %21, i8** %__eout_.i, align 8
  br label %if.end11

if.end11:                                         ; preds = %if.else10, %if.end
  %__cm_12 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 13
  store i32 16, i32* %__cm_12, align 4
  br label %if.end13

if.end13:                                         ; preds = %if.end11, %entry
  ret void
}

; Function Attrs: uwtable
define linkonce_odr %"class.std::__1::basic_filebuf"* @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEE4openEPKcj(%"class.std::__1::basic_filebuf"* %this, i8* %__s, i32 %__mode) #0 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__s.addr = alloca i8*, align 8
  %__mode.addr = alloca i32, align 4
  %__rt = alloca %"class.std::__1::basic_filebuf"*, align 8
  %__mdstr = alloca i8*, align 8
  store %"class.std::__1::basic_filebuf"* %this, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store i8* %__s, i8** %__s.addr, align 8
  store i32 %__mode, i32* %__mode.addr, align 4
  %this1 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %this.addr, align 8
  store %"class.std::__1::basic_filebuf"* null, %"class.std::__1::basic_filebuf"** %__rt, align 8
  %__file_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_, align 8
  %cmp = icmp eq %struct._IO_FILE* %0, null
  br i1 %cmp, label %if.then, label %if.end31

if.then:                                          ; preds = %entry
  store %"class.std::__1::basic_filebuf"* %this1, %"class.std::__1::basic_filebuf"** %__rt, align 8
  %1 = load i32, i32* %__mode.addr, align 4
  %and = and i32 %1, -3
  switch i32 %and, label %sw.default [
    i32 16, label %sw.bb
    i32 48, label %sw.bb
    i32 17, label %sw.bb2
    i32 1, label %sw.bb2
    i32 8, label %sw.bb3
    i32 24, label %sw.bb4
    i32 56, label %sw.bb5
    i32 25, label %sw.bb6
    i32 9, label %sw.bb6
    i32 20, label %sw.bb7
    i32 52, label %sw.bb7
    i32 21, label %sw.bb8
    i32 5, label %sw.bb8
    i32 12, label %sw.bb9
    i32 28, label %sw.bb10
    i32 60, label %sw.bb11
    i32 29, label %sw.bb12
    i32 13, label %sw.bb12
  ]

sw.bb:                                            ; preds = %if.then, %if.then
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb2:                                           ; preds = %if.then, %if.then
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb3:                                           ; preds = %if.then
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb4:                                           ; preds = %if.then
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb5:                                           ; preds = %if.then
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb6:                                           ; preds = %if.then, %if.then
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.6, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb7:                                           ; preds = %if.then, %if.then
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.7, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb8:                                           ; preds = %if.then, %if.then
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.8, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb9:                                           ; preds = %if.then
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.9, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb10:                                          ; preds = %if.then
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.10, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb11:                                          ; preds = %if.then
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.11, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.bb12:                                          ; preds = %if.then, %if.then
  store i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.12, i32 0, i32 0), i8** %__mdstr, align 8
  br label %sw.epilog

sw.default:                                       ; preds = %if.then
  store %"class.std::__1::basic_filebuf"* null, %"class.std::__1::basic_filebuf"** %__rt, align 8
  br label %sw.epilog

sw.epilog:                                        ; preds = %sw.default, %sw.bb12, %sw.bb11, %sw.bb10, %sw.bb9, %sw.bb8, %sw.bb7, %sw.bb6, %sw.bb5, %sw.bb4, %sw.bb3, %sw.bb2, %sw.bb
  %2 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %__rt, align 8
  %tobool = icmp ne %"class.std::__1::basic_filebuf"* %2, null
  br i1 %tobool, label %if.then13, label %if.end30

if.then13:                                        ; preds = %sw.epilog
  %3 = load i8*, i8** %__s.addr, align 8
  %4 = load i8*, i8** %__mdstr, align 8
  %call = call %struct._IO_FILE* @fopen(i8* %3, i8* %4)
  %__file_14 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  store %struct._IO_FILE* %call, %struct._IO_FILE** %__file_14, align 8
  %__file_15 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %5 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_15, align 8
  %tobool16 = icmp ne %struct._IO_FILE* %5, null
  br i1 %tobool16, label %if.then17, label %if.else

if.then17:                                        ; preds = %if.then13
  %6 = load i32, i32* %__mode.addr, align 4
  %__om_ = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 12
  store i32 %6, i32* %__om_, align 8
  %7 = load i32, i32* %__mode.addr, align 4
  %and18 = and i32 %7, 2
  %tobool19 = icmp ne i32 %and18, 0
  br i1 %tobool19, label %if.then20, label %if.end28

if.then20:                                        ; preds = %if.then17
  %__file_21 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_21, align 8
  %call22 = call i32 @fseek(%struct._IO_FILE* %8, i64 0, i32 2)
  %tobool23 = icmp ne i32 %call22, 0
  br i1 %tobool23, label %if.then24, label %if.end

if.then24:                                        ; preds = %if.then20
  %__file_25 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** %__file_25, align 8
  %call26 = call i32 @fclose(%struct._IO_FILE* %9)
  %__file_27 = getelementptr inbounds %"class.std::__1::basic_filebuf", %"class.std::__1::basic_filebuf"* %this1, i32 0, i32 8
  store %struct._IO_FILE* null, %struct._IO_FILE** %__file_27, align 8
  store %"class.std::__1::basic_filebuf"* null, %"class.std::__1::basic_filebuf"** %__rt, align 8
  br label %if.end

if.end:                                           ; preds = %if.then24, %if.then20
  br label %if.end28

if.end28:                                         ; preds = %if.end, %if.then17
  br label %if.end29

if.else:                                          ; preds = %if.then13
  store %"class.std::__1::basic_filebuf"* null, %"class.std::__1::basic_filebuf"** %__rt, align 8
  br label %if.end29

if.end29:                                         ; preds = %if.else, %if.end28
  br label %if.end30

if.end30:                                         ; preds = %if.end29, %sw.epilog
  br label %if.end31

if.end31:                                         ; preds = %if.end30, %entry
  %10 = load %"class.std::__1::basic_filebuf"*, %"class.std::__1::basic_filebuf"** %__rt, align 8
  ret %"class.std::__1::basic_filebuf"* %10
}

declare %struct._IO_FILE* @fopen(i8*, i8*) #5

declare i32 @fseek(%struct._IO_FILE*, i64, i32) #5

declare void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"*, i32) #5

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr void @_ZNSt3__114basic_ofstreamIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_ofstream"* %this, i8** %vtt) unnamed_addr #2 comdat align 2 {
entry:
  %this.addr = alloca %"class.std::__1::basic_ofstream"*, align 8
  %vtt.addr = alloca i8**, align 8
  store %"class.std::__1::basic_ofstream"* %this, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  store i8** %vtt, i8*** %vtt.addr, align 8
  %this1 = load %"class.std::__1::basic_ofstream"*, %"class.std::__1::basic_ofstream"** %this.addr, align 8
  %vtt2 = load i8**, i8*** %vtt.addr, align 8
  %0 = load i8*, i8** %vtt2, align 8
  %1 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i32 (...)***
  %2 = bitcast i8* %0 to i32 (...)**
  store i32 (...)** %2, i32 (...)*** %1, align 8
  %3 = getelementptr inbounds i8*, i8** %vtt2, i64 3
  %4 = load i8*, i8** %3, align 8
  %5 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8**
  %vtable = load i8*, i8** %5, align 8
  %vbase.offset.ptr = getelementptr i8, i8* %vtable, i64 -24
  %6 = bitcast i8* %vbase.offset.ptr to i64*
  %vbase.offset = load i64, i64* %6, align 8
  %7 = bitcast %"class.std::__1::basic_ofstream"* %this1 to i8*
  %add.ptr = getelementptr inbounds i8, i8* %7, i64 %vbase.offset
  %8 = bitcast i8* %add.ptr to i32 (...)***
  %9 = bitcast i8* %4 to i32 (...)**
  store i32 (...)** %9, i32 (...)*** %8, align 8
  %__sb_ = getelementptr inbounds %"class.std::__1::basic_ofstream", %"class.std::__1::basic_ofstream"* %this1, i32 0, i32 1
  call void @_ZNSt3__113basic_filebufIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_filebuf"* %__sb_) #1
  %10 = bitcast %"class.std::__1::basic_ofstream"* %this1 to %"class.std::__1::basic_ostream"*
  %11 = getelementptr inbounds i8*, i8** %vtt2, i64 1
  call void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEED2Ev(%"class.std::__1::basic_ostream"* %10, i8** %11) #1
  ret void
}

; Function Attrs: uwtable
define linkonce_odr dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc(%"class.std::__1::basic_ostream"* dereferenceable(160) %__os, i8* %__str) #0 comdat {
entry:
  %__os.addr = alloca %"class.std::__1::basic_ostream"*, align 8
  %__str.addr = alloca i8*, align 8
  store %"class.std::__1::basic_ostream"* %__os, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  store i8* %__str, i8** %__str.addr, align 8
  %0 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  %1 = load i8*, i8** %__str.addr, align 8
  %2 = load i8*, i8** %__str.addr, align 8
  %call = call i64 @_ZNSt3__111char_traitsIcE6lengthEPKc(i8* %2) #1
  %call1 = call dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m(%"class.std::__1::basic_ostream"* dereferenceable(160) %0, i8* %1, i64 %call)
  ret %"class.std::__1::basic_ostream"* %call1
}

declare dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEm(%"class.std::__1::basic_ostream"*, i64) #5

; Function Attrs: uwtable
define linkonce_odr dereferenceable(160) %"class.std::__1::basic_ostream"* @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m(%"class.std::__1::basic_ostream"* dereferenceable(160) %__os, i8* %__str, i64 %__len) #0 comdat personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr.i.i.i48 = alloca %"class.std::__1::ctype"*, align 8
  %__c.addr.i.i.i = alloca i8, align 1
  %__l.addr.i.i.i = alloca %"class.std::__1::locale"*, align 8
  %this.addr.i.i49 = alloca %"class.std::__1::basic_ios"*, align 8
  %__c.addr.i.i = alloca i8, align 1
  %ref.tmp.i.i = alloca %"class.std::__1::locale", align 8
  %exn.slot.i.i = alloca i8*
  %ehselector.slot.i.i = alloca i32
  %this.addr.i50 = alloca %"class.std::__1::basic_ios"*, align 8
  %this.addr.i45 = alloca %"class.std::__1::ostreambuf_iterator"*, align 8
  %this.addr.i43 = alloca %"class.std::__1::ios_base"*, align 8
  %this.addr.i.i39 = alloca %"class.std::__1::ios_base"*, align 8
  %__state.addr.i.i = alloca i32, align 4
  %this.addr.i40 = alloca %"class.std::__1::basic_ios"*, align 8
  %__state.addr.i = alloca i32, align 4
  %this.addr.i.i.i = alloca %"class.std::__1::ios_base"*, align 8
  %this.addr.i.i = alloca %"class.std::__1::basic_ios"*, align 8
  %this.addr.i37 = alloca %"class.std::__1::ostreambuf_iterator"*, align 8
  %__s.addr.i = alloca %"class.std::__1::basic_ostream"*, align 8
  %this.addr.i = alloca %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"*, align 8
  %__os.addr = alloca %"class.std::__1::basic_ostream"*, align 8
  %__str.addr = alloca i8*, align 8
  %__len.addr = alloca i64, align 8
  %__s = alloca %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry", align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %agg.tmp = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %coerce = alloca %"class.std::__1::ostreambuf_iterator", align 8
  store %"class.std::__1::basic_ostream"* %__os, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  store i8* %__str, i8** %__str.addr, align 8
  store i64 %__len, i64* %__len.addr, align 8
  %0 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  invoke void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %__s, %"class.std::__1::basic_ostream"* dereferenceable(160) %0)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  store %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %__s, %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"*, %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"** %this.addr.i, align 8
  %__ok_.i = getelementptr inbounds %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry", %"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %this1.i, i32 0, i32 0
  %1 = load i8, i8* %__ok_.i, align 8
  %tobool.i = trunc i8 %1 to i1
  br label %invoke.cont2

invoke.cont2:                                     ; preds = %invoke.cont
  br i1 %tobool.i, label %if.then, label %if.end27

if.then:                                          ; preds = %invoke.cont2
  %2 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  store %"class.std::__1::ostreambuf_iterator"* %agg.tmp, %"class.std::__1::ostreambuf_iterator"** %this.addr.i37, align 8
  store %"class.std::__1::basic_ostream"* %2, %"class.std::__1::basic_ostream"** %__s.addr.i, align 8
  %this1.i38 = load %"class.std::__1::ostreambuf_iterator"*, %"class.std::__1::ostreambuf_iterator"** %this.addr.i37, align 8
  %3 = bitcast %"class.std::__1::ostreambuf_iterator"* %this1.i38 to %"struct.std::__1::iterator"*
  %__sbuf_.i = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %this1.i38, i32 0, i32 0
  %4 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__s.addr.i, align 8
  %5 = bitcast %"class.std::__1::basic_ostream"* %4 to i8**
  %vtable.i = load i8*, i8** %5, align 8
  %vbase.offset.ptr.i = getelementptr i8, i8* %vtable.i, i64 -24
  %6 = bitcast i8* %vbase.offset.ptr.i to i64*
  %vbase.offset.i = load i64, i64* %6, align 8
  %7 = bitcast %"class.std::__1::basic_ostream"* %4 to i8*
  %add.ptr.i = getelementptr inbounds i8, i8* %7, i64 %vbase.offset.i
  %8 = bitcast i8* %add.ptr.i to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %8, %"class.std::__1::basic_ios"** %this.addr.i.i, align 8
  %this1.i.i = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i.i, align 8
  %9 = bitcast %"class.std::__1::basic_ios"* %this1.i.i to %"class.std::__1::ios_base"*
  store %"class.std::__1::ios_base"* %9, %"class.std::__1::ios_base"** %this.addr.i.i.i, align 8
  %this1.i.i.i = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %this.addr.i.i.i, align 8
  %__rdbuf_.i.i.i = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %this1.i.i.i, i32 0, i32 6
  %10 = load i8*, i8** %__rdbuf_.i.i.i, align 8
  %11 = bitcast i8* %10 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %11, %"class.std::__1::basic_streambuf"** %__sbuf_.i, align 8
  %12 = load i8*, i8** %__str.addr, align 8
  %13 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  %14 = bitcast %"class.std::__1::basic_ostream"* %13 to i8**
  %vtable = load i8*, i8** %14, align 8
  %vbase.offset.ptr = getelementptr i8, i8* %vtable, i64 -24
  %15 = bitcast i8* %vbase.offset.ptr to i64*
  %vbase.offset = load i64, i64* %15, align 8
  %16 = bitcast %"class.std::__1::basic_ostream"* %13 to i8*
  %add.ptr = getelementptr inbounds i8, i8* %16, i64 %vbase.offset
  %17 = bitcast i8* %add.ptr to %"class.std::__1::ios_base"*
  store %"class.std::__1::ios_base"* %17, %"class.std::__1::ios_base"** %this.addr.i43, align 8
  %this1.i44 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %this.addr.i43, align 8
  %__fmtflags_.i = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %this1.i44, i32 0, i32 1
  %18 = load i32, i32* %__fmtflags_.i, align 8
  br label %invoke.cont3

invoke.cont3:                                     ; preds = %if.then
  %and = and i32 %18, 176
  %cmp = icmp eq i32 %and, 32
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %invoke.cont3
  %19 = load i8*, i8** %__str.addr, align 8
  %20 = load i64, i64* %__len.addr, align 8
  %add.ptr5 = getelementptr inbounds i8, i8* %19, i64 %20
  br label %cond.end

cond.false:                                       ; preds = %invoke.cont3
  %21 = load i8*, i8** %__str.addr, align 8
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i8* [ %add.ptr5, %cond.true ], [ %21, %cond.false ]
  %22 = load i8*, i8** %__str.addr, align 8
  %23 = load i64, i64* %__len.addr, align 8
  %add.ptr6 = getelementptr inbounds i8, i8* %22, i64 %23
  %24 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  %25 = bitcast %"class.std::__1::basic_ostream"* %24 to i8**
  %vtable7 = load i8*, i8** %25, align 8
  %vbase.offset.ptr8 = getelementptr i8, i8* %vtable7, i64 -24
  %26 = bitcast i8* %vbase.offset.ptr8 to i64*
  %vbase.offset9 = load i64, i64* %26, align 8
  %27 = bitcast %"class.std::__1::basic_ostream"* %24 to i8*
  %add.ptr10 = getelementptr inbounds i8, i8* %27, i64 %vbase.offset9
  %28 = bitcast i8* %add.ptr10 to %"class.std::__1::ios_base"*
  %29 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  %30 = bitcast %"class.std::__1::basic_ostream"* %29 to i8**
  %vtable11 = load i8*, i8** %30, align 8
  %vbase.offset.ptr12 = getelementptr i8, i8* %vtable11, i64 -24
  %31 = bitcast i8* %vbase.offset.ptr12 to i64*
  %vbase.offset13 = load i64, i64* %31, align 8
  %32 = bitcast %"class.std::__1::basic_ostream"* %29 to i8*
  %add.ptr14 = getelementptr inbounds i8, i8* %32, i64 %vbase.offset13
  %33 = bitcast i8* %add.ptr14 to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %33, %"class.std::__1::basic_ios"** %this.addr.i50, align 8
  %this1.i51 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i50, align 8
  %call.i = call i32 @_ZNSt3__111char_traitsIcE3eofEv() #1
  %__fill_.i = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %this1.i51, i32 0, i32 2
  %34 = load i32, i32* %__fill_.i, align 8
  %call2.i = call zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 %call.i, i32 %34) #1
  br i1 %call2.i, label %if.then.i, label %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit

if.then.i:                                        ; preds = %cond.end
  store %"class.std::__1::basic_ios"* %this1.i51, %"class.std::__1::basic_ios"** %this.addr.i.i49, align 8
  store i8 32, i8* %__c.addr.i.i, align 1
  %this1.i.i52 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i.i49, align 8
  %35 = bitcast %"class.std::__1::basic_ios"* %this1.i.i52 to %"class.std::__1::ios_base"*
  invoke void @_ZNKSt3__18ios_base6getlocEv(%"class.std::__1::locale"* sret %ref.tmp.i.i, %"class.std::__1::ios_base"* %35)
          to label %.noexc unwind label %lpad1

.noexc:                                           ; preds = %if.then.i
  store %"class.std::__1::locale"* %ref.tmp.i.i, %"class.std::__1::locale"** %__l.addr.i.i.i, align 8
  %36 = load %"class.std::__1::locale"*, %"class.std::__1::locale"** %__l.addr.i.i.i, align 8
  %call.i5.i.i = invoke %"class.std::__1::locale::facet"* @_ZNKSt3__16locale9use_facetERNS0_2idE(%"class.std::__1::locale"* %36, %"class.std::__1::locale::id"* dereferenceable(16) @_ZNSt3__15ctypeIcE2idE)
          to label %_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i unwind label %lpad.i.i

_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i: ; preds = %.noexc
  %37 = bitcast %"class.std::__1::locale::facet"* %call.i5.i.i to %"class.std::__1::ctype"*
  %38 = load i8, i8* %__c.addr.i.i, align 1
  store %"class.std::__1::ctype"* %37, %"class.std::__1::ctype"** %this.addr.i.i.i48, align 8
  store i8 %38, i8* %__c.addr.i.i.i, align 1
  %this1.i.i.i53 = load %"class.std::__1::ctype"*, %"class.std::__1::ctype"** %this.addr.i.i.i48, align 8
  %39 = bitcast %"class.std::__1::ctype"* %this1.i.i.i53 to i8 (%"class.std::__1::ctype"*, i8)***
  %vtable.i.i.i = load i8 (%"class.std::__1::ctype"*, i8)**, i8 (%"class.std::__1::ctype"*, i8)*** %39, align 8
  %vfn.i.i.i = getelementptr inbounds i8 (%"class.std::__1::ctype"*, i8)*, i8 (%"class.std::__1::ctype"*, i8)** %vtable.i.i.i, i64 7
  %40 = load i8 (%"class.std::__1::ctype"*, i8)*, i8 (%"class.std::__1::ctype"*, i8)** %vfn.i.i.i, align 8
  %41 = load i8, i8* %__c.addr.i.i.i, align 1
  %call.i6.i.i = invoke signext i8 %40(%"class.std::__1::ctype"* %this1.i.i.i53, i8 signext %41)
          to label %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit.i unwind label %lpad.i.i

lpad.i.i:                                         ; preds = %_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i, %.noexc
  %42 = landingpad { i8*, i32 }
          cleanup
          catch i8* null
  %43 = extractvalue { i8*, i32 } %42, 0
  store i8* %43, i8** %exn.slot.i.i, align 8
  %44 = extractvalue { i8*, i32 } %42, 1
  store i32 %44, i32* %ehselector.slot.i.i, align 4
  call void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* %ref.tmp.i.i) #1
  %exn.i.i = load i8*, i8** %exn.slot.i.i, align 8
  %sel.i.i = load i32, i32* %ehselector.slot.i.i, align 4
  %lpad.val.i.i = insertvalue { i8*, i32 } undef, i8* %exn.i.i, 0
  %lpad.val4.i.i = insertvalue { i8*, i32 } %lpad.val.i.i, i32 %sel.i.i, 1
  br label %lpad1.body

_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit.i: ; preds = %_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE.exit.i.i
  call void @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* %ref.tmp.i.i) #1
  %conv.i = sext i8 %call.i6.i.i to i32
  %__fill_4.i = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %this1.i51, i32 0, i32 2
  store i32 %conv.i, i32* %__fill_4.i, align 8
  br label %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit

_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit: ; preds = %cond.end, %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc.exit.i
  %__fill_5.i = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %this1.i51, i32 0, i32 2
  %45 = load i32, i32* %__fill_5.i, align 8
  %conv6.i = trunc i32 %45 to i8
  br label %invoke.cont15

invoke.cont15:                                    ; preds = %_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv.exit
  %coerce.dive = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %agg.tmp, i32 0, i32 0
  %46 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %coerce.dive, align 8
  %call18 = invoke %"class.std::__1::basic_streambuf"* @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_(%"class.std::__1::basic_streambuf"* %46, i8* %12, i8* %cond, i8* %add.ptr6, %"class.std::__1::ios_base"* dereferenceable(136) %28, i8 signext %conv6.i)
          to label %invoke.cont17 unwind label %lpad1

invoke.cont17:                                    ; preds = %invoke.cont15
  %coerce.dive19 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %coerce, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* %call18, %"class.std::__1::basic_streambuf"** %coerce.dive19, align 8
  store %"class.std::__1::ostreambuf_iterator"* %coerce, %"class.std::__1::ostreambuf_iterator"** %this.addr.i45, align 8
  %this1.i46 = load %"class.std::__1::ostreambuf_iterator"*, %"class.std::__1::ostreambuf_iterator"** %this.addr.i45, align 8
  %__sbuf_.i47 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %this1.i46, i32 0, i32 0
  %47 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %__sbuf_.i47, align 8
  %cmp.i = icmp eq %"class.std::__1::basic_streambuf"* %47, null
  br i1 %cmp.i, label %if.then21, label %if.end

if.then21:                                        ; preds = %invoke.cont17
  %48 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  %49 = bitcast %"class.std::__1::basic_ostream"* %48 to i8**
  %vtable22 = load i8*, i8** %49, align 8
  %vbase.offset.ptr23 = getelementptr i8, i8* %vtable22, i64 -24
  %50 = bitcast i8* %vbase.offset.ptr23 to i64*
  %vbase.offset24 = load i64, i64* %50, align 8
  %51 = bitcast %"class.std::__1::basic_ostream"* %48 to i8*
  %add.ptr25 = getelementptr inbounds i8, i8* %51, i64 %vbase.offset24
  %52 = bitcast i8* %add.ptr25 to %"class.std::__1::basic_ios"*
  store %"class.std::__1::basic_ios"* %52, %"class.std::__1::basic_ios"** %this.addr.i40, align 8
  store i32 5, i32* %__state.addr.i, align 4
  %this1.i41 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %this.addr.i40, align 8
  %53 = bitcast %"class.std::__1::basic_ios"* %this1.i41 to %"class.std::__1::ios_base"*
  %54 = load i32, i32* %__state.addr.i, align 4
  store %"class.std::__1::ios_base"* %53, %"class.std::__1::ios_base"** %this.addr.i.i39, align 8
  store i32 %54, i32* %__state.addr.i.i, align 4
  %this1.i.i42 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %this.addr.i.i39, align 8
  %__rdstate_.i.i = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %this1.i.i42, i32 0, i32 4
  %55 = load i32, i32* %__rdstate_.i.i, align 8
  %56 = load i32, i32* %__state.addr.i.i, align 4
  %or.i.i = or i32 %55, %56
  invoke void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"* %this1.i.i42, i32 %or.i.i)
          to label %_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj.exit unwind label %lpad1

_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj.exit: ; preds = %if.then21
  br label %invoke.cont26

invoke.cont26:                                    ; preds = %_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj.exit
  br label %if.end

lpad:                                             ; preds = %entry
  %57 = landingpad { i8*, i32 }
          catch i8* null
  %58 = extractvalue { i8*, i32 } %57, 0
  store i8* %58, i8** %exn.slot, align 8
  %59 = extractvalue { i8*, i32 } %57, 1
  store i32 %59, i32* %ehselector.slot, align 4
  br label %catch

lpad1:                                            ; preds = %if.then.i, %if.then21, %invoke.cont15
  %60 = landingpad { i8*, i32 }
          catch i8* null
  br label %lpad1.body

lpad1.body:                                       ; preds = %lpad.i.i, %lpad1
  %eh.lpad-body = phi { i8*, i32 } [ %60, %lpad1 ], [ %lpad.val4.i.i, %lpad.i.i ]
  %61 = extractvalue { i8*, i32 } %eh.lpad-body, 0
  store i8* %61, i8** %exn.slot, align 8
  %62 = extractvalue { i8*, i32 } %eh.lpad-body, 1
  store i32 %62, i32* %ehselector.slot, align 4
  call void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %__s) #1
  br label %catch

catch:                                            ; preds = %lpad1.body, %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  %63 = call i8* @__cxa_begin_catch(i8* %exn) #1
  %64 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  %65 = bitcast %"class.std::__1::basic_ostream"* %64 to i8**
  %vtable28 = load i8*, i8** %65, align 8
  %vbase.offset.ptr29 = getelementptr i8, i8* %vtable28, i64 -24
  %66 = bitcast i8* %vbase.offset.ptr29 to i64*
  %vbase.offset30 = load i64, i64* %66, align 8
  %67 = bitcast %"class.std::__1::basic_ostream"* %64 to i8*
  %add.ptr31 = getelementptr inbounds i8, i8* %67, i64 %vbase.offset30
  %68 = bitcast i8* %add.ptr31 to %"class.std::__1::ios_base"*
  invoke void @_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv(%"class.std::__1::ios_base"* %68)
          to label %invoke.cont33 unwind label %lpad32

invoke.cont33:                                    ; preds = %catch
  call void @__cxa_end_catch()
  br label %try.cont

try.cont:                                         ; preds = %invoke.cont33, %if.end27
  %69 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %__os.addr, align 8
  ret %"class.std::__1::basic_ostream"* %69

if.end:                                           ; preds = %invoke.cont26, %invoke.cont17
  br label %if.end27

if.end27:                                         ; preds = %if.end, %invoke.cont2
  call void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"* %__s) #1
  br label %try.cont

lpad32:                                           ; preds = %catch
  %70 = landingpad { i8*, i32 }
          cleanup
  %71 = extractvalue { i8*, i32 } %70, 0
  store i8* %71, i8** %exn.slot, align 8
  %72 = extractvalue { i8*, i32 } %70, 1
  store i32 %72, i32* %ehselector.slot, align 4
  invoke void @__cxa_end_catch()
          to label %invoke.cont34 unwind label %terminate.lpad

invoke.cont34:                                    ; preds = %lpad32
  br label %eh.resume

eh.resume:                                        ; preds = %invoke.cont34
  %exn35 = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn35, 0
  %lpad.val36 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val36

terminate.lpad:                                   ; preds = %lpad32
  %73 = landingpad { i8*, i32 }
          catch i8* null
  %74 = extractvalue { i8*, i32 } %73, 0
  call void @__clang_call_terminate(i8* %74) #12
  unreachable
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr i64 @_ZNSt3__111char_traitsIcE6lengthEPKc(i8* %__s) #2 comdat align 2 {
entry:
  %__s.addr = alloca i8*, align 8
  store i8* %__s, i8** %__s.addr, align 8
  %0 = load i8*, i8** %__s.addr, align 8
  %call = call i64 @strlen(i8* %0) #16
  ret i64 %call
}

declare void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"*, %"class.std::__1::basic_ostream"* dereferenceable(160)) unnamed_addr #5

; Function Attrs: uwtable
define linkonce_odr hidden %"class.std::__1::basic_streambuf"* @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_(%"class.std::__1::basic_streambuf"* %__s.coerce, i8* %__ob, i8* %__op, i8* %__oe, %"class.std::__1::ios_base"* dereferenceable(136) %__iob, i8 signext %__fl) #0 comdat personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
entry:
  %this.addr.i76 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__s.addr.i77 = alloca i8*, align 8
  %__n.addr.i78 = alloca i64, align 8
  %__p.addr.i.i = alloca i8*, align 8
  %this.addr.i.i.i13.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i14.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i15.i.i = alloca %"class.std::__1::basic_string"*, align 8
  %__x.addr.i.i.i.i.i56 = alloca i8*, align 8
  %__r.addr.i.i.i.i57 = alloca i8*, align 8
  %this.addr.i.i.i4.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i5.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i6.i.i = alloca %"class.std::__1::basic_string"*, align 8
  %this.addr.i.i.i.i.i58 = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i.i.i59 = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i.i.i60 = alloca %"class.std::__1::basic_string"*, align 8
  %this.addr.i.i61 = alloca %"class.std::__1::basic_string"*, align 8
  %this.addr.i62 = alloca %"class.std::__1::basic_string"*, align 8
  %this.addr.i.i.i63.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i64.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i65.i.i = alloca %"class.std::__1::basic_string"*, align 8
  %__s.addr.i.i.i.i = alloca i64, align 8
  %__s.addr.i61.i.i = alloca i64, align 8
  %__size.addr.i.i.i.i.i = alloca i64, align 8
  %this.addr.i.i.i57.i.i = alloca %"class.std::__1::allocator"*, align 8
  %this.addr.i.i58.i.i = alloca %"class.std::__1::allocator"*, align 8
  %__n.addr.i.i.i.i = alloca i64, align 8
  %.addr.i.i.i.i = alloca i8*, align 8
  %__a.addr.i.i.i = alloca %"class.std::__1::allocator"*, align 8
  %__n.addr.i.i.i = alloca i64, align 8
  %this.addr.i.i.i46.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i47.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i48.i.i = alloca %"class.std::__1::basic_string"*, align 8
  %__p.addr.i49.i.i = alloca i8*, align 8
  %this.addr.i.i.i36.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i37.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i38.i.i = alloca %"class.std::__1::basic_string"*, align 8
  %__s.addr.i39.i.i = alloca i64, align 8
  %this.addr.i.i.i26.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i27.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i28.i.i = alloca %"class.std::__1::basic_string"*, align 8
  %__s.addr.i29.i.i = alloca i64, align 8
  %__p.addr.i.i.i = alloca i8*, align 8
  %__x.addr.i.i.i.i.i = alloca i8*, align 8
  %__r.addr.i.i.i.i = alloca i8*, align 8
  %this.addr.i.i.i18.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i19.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i20.i.i = alloca %"class.std::__1::basic_string"*, align 8
  %this.addr.i.i.i12.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i13.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i14.i.i = alloca %"class.std::__1::basic_string"*, align 8
  %__s.addr.i.i.i = alloca i64, align 8
  %this.addr.i.i.i3.i.i.i = alloca %"class.std::__1::allocator"*, align 8
  %0 = alloca %"struct.std::__1::integral_constant", align 1
  %__a.addr.i.i.i.i.i = alloca %"class.std::__1::allocator"*, align 8
  %__a.addr.i.i.i.i = alloca %"class.std::__1::allocator"*, align 8
  %agg.tmp.i.i.i.i = alloca %"struct.std::__1::integral_constant", align 1
  %ref.tmp.i.i.i.i = alloca %"struct.std::__1::__has_max_size", align 1
  %this.addr.i.i.i.i.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i.i.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i.i.i2.i = alloca %"class.std::__1::basic_string"*, align 8
  %this.addr.i.i3.i = alloca %"class.std::__1::basic_string"*, align 8
  %__m.i.i.i = alloca i64, align 8
  %this.addr.i4.i = alloca %"class.std::__1::basic_string"*, align 8
  %__n.addr.i.i = alloca i64, align 8
  %__c.addr.i.i = alloca i8, align 1
  %__p.i.i = alloca i8*, align 8
  %__cap.i.i = alloca i64, align 8
  %ref.tmp.i.i = alloca i8, align 1
  %this.addr.i.i.i.i = alloca %"class.std::__1::allocator"*, align 8
  %this.addr.i.i.i = alloca %"class.std::__1::__libcpp_compressed_pair_imp.2"*, align 8
  %this.addr.i.i = alloca %"class.std::__1::__compressed_pair.1"*, align 8
  %this.addr.i53 = alloca %"class.std::__1::basic_string"*, align 8
  %__n.addr.i54 = alloca i64, align 8
  %__c.addr.i = alloca i8, align 1
  %this.addr.i46 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__s.addr.i47 = alloca i8*, align 8
  %__n.addr.i48 = alloca i64, align 8
  %this.addr.i44 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %__s.addr.i = alloca i8*, align 8
  %__n.addr.i = alloca i64, align 8
  %this.addr.i41 = alloca %"class.std::__1::ios_base"*, align 8
  %__wide.addr.i = alloca i64, align 8
  %__r.i = alloca i64, align 8
  %this.addr.i = alloca %"class.std::__1::ios_base"*, align 8
  %retval = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %__s = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %__ob.addr = alloca i8*, align 8
  %__op.addr = alloca i8*, align 8
  %__oe.addr = alloca i8*, align 8
  %__iob.addr = alloca %"class.std::__1::ios_base"*, align 8
  %__fl.addr = alloca i8, align 1
  %__sz = alloca i64, align 8
  %__ns = alloca i64, align 8
  %__np = alloca i64, align 8
  %__sp = alloca %"class.std::__1::basic_string", align 8
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  %cleanup.dest.slot = alloca i32
  %coerce.dive = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* %__s.coerce, %"class.std::__1::basic_streambuf"** %coerce.dive, align 8
  store i8* %__ob, i8** %__ob.addr, align 8
  store i8* %__op, i8** %__op.addr, align 8
  store i8* %__oe, i8** %__oe.addr, align 8
  store %"class.std::__1::ios_base"* %__iob, %"class.std::__1::ios_base"** %__iob.addr, align 8
  store i8 %__fl, i8* %__fl.addr, align 1
  %__sbuf_ = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  %1 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %__sbuf_, align 8
  %cmp = icmp eq %"class.std::__1::basic_streambuf"* %1, null
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = bitcast %"class.std::__1::ostreambuf_iterator"* %retval to i8*
  %3 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 8, i32 8, i1 false)
  br label %return

if.end:                                           ; preds = %entry
  %4 = load i8*, i8** %__oe.addr, align 8
  %5 = load i8*, i8** %__ob.addr, align 8
  %sub.ptr.lhs.cast = ptrtoint i8* %4 to i64
  %sub.ptr.rhs.cast = ptrtoint i8* %5 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  store i64 %sub.ptr.sub, i64* %__sz, align 8
  %6 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %__iob.addr, align 8
  store %"class.std::__1::ios_base"* %6, %"class.std::__1::ios_base"** %this.addr.i, align 8
  %this1.i = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %this.addr.i, align 8
  %__width_.i = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %this1.i, i32 0, i32 3
  %7 = load i64, i64* %__width_.i, align 8
  store i64 %7, i64* %__ns, align 8
  %8 = load i64, i64* %__ns, align 8
  %9 = load i64, i64* %__sz, align 8
  %cmp1 = icmp sgt i64 %8, %9
  br i1 %cmp1, label %if.then2, label %if.else

if.then2:                                         ; preds = %if.end
  %10 = load i64, i64* %__sz, align 8
  %11 = load i64, i64* %__ns, align 8
  %sub = sub nsw i64 %11, %10
  store i64 %sub, i64* %__ns, align 8
  br label %if.end3

if.else:                                          ; preds = %if.end
  store i64 0, i64* %__ns, align 8
  br label %if.end3

if.end3:                                          ; preds = %if.else, %if.then2
  %12 = load i8*, i8** %__op.addr, align 8
  %13 = load i8*, i8** %__ob.addr, align 8
  %sub.ptr.lhs.cast4 = ptrtoint i8* %12 to i64
  %sub.ptr.rhs.cast5 = ptrtoint i8* %13 to i64
  %sub.ptr.sub6 = sub i64 %sub.ptr.lhs.cast4, %sub.ptr.rhs.cast5
  store i64 %sub.ptr.sub6, i64* %__np, align 8
  %14 = load i64, i64* %__np, align 8
  %cmp7 = icmp sgt i64 %14, 0
  br i1 %cmp7, label %if.then8, label %if.end15

if.then8:                                         ; preds = %if.end3
  %__sbuf_9 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  %15 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %__sbuf_9, align 8
  %16 = load i8*, i8** %__ob.addr, align 8
  %17 = load i64, i64* %__np, align 8
  store %"class.std::__1::basic_streambuf"* %15, %"class.std::__1::basic_streambuf"** %this.addr.i46, align 8
  store i8* %16, i8** %__s.addr.i47, align 8
  store i64 %17, i64* %__n.addr.i48, align 8
  %this1.i49 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i46, align 8
  %18 = bitcast %"class.std::__1::basic_streambuf"* %this1.i49 to i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)***
  %vtable.i50 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)**, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*** %18, align 8
  %vfn.i51 = getelementptr inbounds i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %vtable.i50, i64 12
  %19 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %vfn.i51, align 8
  %20 = load i8*, i8** %__s.addr.i47, align 8
  %21 = load i64, i64* %__n.addr.i48, align 8
  %call.i52 = call i64 %19(%"class.std::__1::basic_streambuf"* %this1.i49, i8* %20, i64 %21)
  %22 = load i64, i64* %__np, align 8
  %cmp11 = icmp ne i64 %call.i52, %22
  br i1 %cmp11, label %if.then12, label %if.end14

if.then12:                                        ; preds = %if.then8
  %__sbuf_13 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %__sbuf_13, align 8
  %23 = bitcast %"class.std::__1::ostreambuf_iterator"* %retval to i8*
  %24 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %23, i8* %24, i64 8, i32 8, i1 false)
  br label %return

if.end14:                                         ; preds = %if.then8
  br label %if.end15

if.end15:                                         ; preds = %if.end14, %if.end3
  %25 = load i64, i64* %__ns, align 8
  %cmp16 = icmp sgt i64 %25, 0
  br i1 %cmp16, label %if.then17, label %if.end25

if.then17:                                        ; preds = %if.end15
  %26 = load i64, i64* %__ns, align 8
  %27 = load i8, i8* %__fl.addr, align 1
  store %"class.std::__1::basic_string"* %__sp, %"class.std::__1::basic_string"** %this.addr.i53, align 8
  store i64 %26, i64* %__n.addr.i54, align 8
  store i8 %27, i8* %__c.addr.i, align 1
  %this1.i55 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i53, align 8
  %28 = bitcast %"class.std::__1::basic_string"* %this1.i55 to %"class.std::__1::__basic_string_common"*
  %__r_.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i55, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i, align 8
  %this1.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i, align 8
  %29 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %29, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i, align 8
  %this1.i.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i, align 8
  %30 = bitcast %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i to %"class.std::__1::allocator"*
  store %"class.std::__1::allocator"* %30, %"class.std::__1::allocator"** %this.addr.i.i.i.i, align 8
  %this1.i.i.i.i = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %this.addr.i.i.i.i, align 8
  %__first_.i.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i, i32 0, i32 0
  %31 = bitcast %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i to i8*
  call void @llvm.memset.p0i8.i64(i8* %31, i8 0, i64 24, i32 8, i1 false) #1
  %32 = load i64, i64* %__n.addr.i54, align 8
  %33 = load i8, i8* %__c.addr.i, align 1
  store %"class.std::__1::basic_string"* %this1.i55, %"class.std::__1::basic_string"** %this.addr.i4.i, align 8
  store i64 %32, i64* %__n.addr.i.i, align 8
  store i8 %33, i8* %__c.addr.i.i, align 1
  %this1.i5.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i4.i, align 8
  %34 = load i64, i64* %__n.addr.i.i, align 8
  store %"class.std::__1::basic_string"* %this1.i5.i, %"class.std::__1::basic_string"** %this.addr.i.i3.i, align 8
  %this1.i.i6.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i.i3.i, align 8
  store %"class.std::__1::basic_string"* %this1.i.i6.i, %"class.std::__1::basic_string"** %this.addr.i.i.i2.i, align 8
  %this1.i.i.i7.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i.i.i2.i, align 8
  %__r_.i.i.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i.i.i7.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i.i.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i.i.i.i, align 8
  %this1.i.i.i.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i.i.i.i, align 8
  %35 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i.i.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %35, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i.i.i.i, align 8
  %this1.i.i.i.i.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i.i.i.i, align 8
  %36 = bitcast %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i.i.i.i to %"class.std::__1::allocator"*
  store %"class.std::__1::allocator"* %36, %"class.std::__1::allocator"** %__a.addr.i.i.i.i, align 8
  %37 = bitcast %"struct.std::__1::__has_max_size"* %ref.tmp.i.i.i.i to %"struct.std::__1::integral_constant"*
  %38 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %__a.addr.i.i.i.i, align 8
  store %"class.std::__1::allocator"* %38, %"class.std::__1::allocator"** %__a.addr.i.i.i.i.i, align 8
  %39 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %__a.addr.i.i.i.i.i, align 8
  store %"class.std::__1::allocator"* %39, %"class.std::__1::allocator"** %this.addr.i.i.i3.i.i.i, align 8
  %this1.i.i.i4.i.i.i = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %this.addr.i.i.i3.i.i.i, align 8
  store i64 -1, i64* %__m.i.i.i, align 8
  %40 = load i64, i64* %__m.i.i.i, align 8
  %sub.i.i.i = sub i64 %40, 16
  %cmp.i.i = icmp ugt i64 %34, %sub.i.i.i
  br i1 %cmp.i.i, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %if.then17
  %41 = bitcast %"class.std::__1::basic_string"* %this1.i5.i to %"class.std::__1::__basic_string_common"*
  call void @_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv(%"class.std::__1::__basic_string_common"* %41) #15
  unreachable

if.end.i.i:                                       ; preds = %if.then17
  %42 = load i64, i64* %__n.addr.i.i, align 8
  %cmp2.i.i = icmp ult i64 %42, 23
  br i1 %cmp2.i.i, label %if.then3.i.i, label %if.else.i.i

if.then3.i.i:                                     ; preds = %if.end.i.i
  %43 = load i64, i64* %__n.addr.i.i, align 8
  store %"class.std::__1::basic_string"* %this1.i5.i, %"class.std::__1::basic_string"** %this.addr.i14.i.i, align 8
  store i64 %43, i64* %__s.addr.i.i.i, align 8
  %this1.i15.i.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i14.i.i, align 8
  %44 = load i64, i64* %__s.addr.i.i.i, align 8
  %shl.i.i.i = shl i64 %44, 1
  %conv.i.i.i = trunc i64 %shl.i.i.i to i8
  %__r_.i.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i15.i.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i13.i.i, align 8
  %this1.i.i16.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i13.i.i, align 8
  %45 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i16.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %45, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i12.i.i, align 8
  %this1.i.i.i17.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i12.i.i, align 8
  %__first_.i.i.i.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i17.i.i, i32 0, i32 0
  %46 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i.i.i, i32 0, i32 0
  %__s2.i.i.i = bitcast %union.anon.3* %46 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"*
  %47 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"* %__s2.i.i.i, i32 0, i32 0
  %__size_.i.i.i = bitcast %union.anon.4* %47 to i8*
  store i8 %conv.i.i.i, i8* %__size_.i.i.i, align 8
  store %"class.std::__1::basic_string"* %this1.i5.i, %"class.std::__1::basic_string"** %this.addr.i20.i.i, align 8
  %this1.i21.i.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i20.i.i, align 8
  %__r_.i22.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i21.i.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i22.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i19.i.i, align 8
  %this1.i.i23.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i19.i.i, align 8
  %48 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i23.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %48, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i18.i.i, align 8
  %this1.i.i.i24.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i18.i.i, align 8
  %__first_.i.i.i25.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i24.i.i, i32 0, i32 0
  %49 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i25.i.i, i32 0, i32 0
  %__s.i.i.i = bitcast %union.anon.3* %49 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"*
  %__data_.i.i.i = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"* %__s.i.i.i, i32 0, i32 1
  %arrayidx.i.i.i = getelementptr inbounds [23 x i8], [23 x i8]* %__data_.i.i.i, i64 0, i64 0
  store i8* %arrayidx.i.i.i, i8** %__r.addr.i.i.i.i, align 8
  %50 = load i8*, i8** %__r.addr.i.i.i.i, align 8
  store i8* %50, i8** %__x.addr.i.i.i.i.i, align 8
  %51 = load i8*, i8** %__x.addr.i.i.i.i.i, align 8
  store i8* %51, i8** %__p.i.i, align 8
  br label %_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2Emc.exit

if.else.i.i:                                      ; preds = %if.end.i.i
  %52 = load i64, i64* %__n.addr.i.i, align 8
  store i64 %52, i64* %__s.addr.i61.i.i, align 8
  %53 = load i64, i64* %__s.addr.i61.i.i, align 8
  %cmp.i.i.i = icmp ult i64 %53, 23
  br i1 %cmp.i.i.i, label %cond.true.i.i.i, label %cond.false.i.i.i

cond.true.i.i.i:                                  ; preds = %if.else.i.i
  br label %_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE11__recommendEm.exit.i.i

cond.false.i.i.i:                                 ; preds = %if.else.i.i
  %54 = load i64, i64* %__s.addr.i61.i.i, align 8
  %add.i.i.i = add i64 %54, 1
  store i64 %add.i.i.i, i64* %__s.addr.i.i.i.i, align 8
  %55 = load i64, i64* %__s.addr.i.i.i.i, align 8
  %add.i.i.i.i = add i64 %55, 15
  %and.i.i.i.i = and i64 %add.i.i.i.i, -16
  br label %_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE11__recommendEm.exit.i.i

_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE11__recommendEm.exit.i.i: ; preds = %cond.false.i.i.i, %cond.true.i.i.i
  %cond.i.i.i = phi i64 [ 23, %cond.true.i.i.i ], [ %and.i.i.i.i, %cond.false.i.i.i ]
  %sub.i62.i.i = sub i64 %cond.i.i.i, 1
  store i64 %sub.i62.i.i, i64* %__cap.i.i, align 8
  store %"class.std::__1::basic_string"* %this1.i5.i, %"class.std::__1::basic_string"** %this.addr.i65.i.i, align 8
  %this1.i66.i.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i65.i.i, align 8
  %__r_.i67.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i66.i.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i67.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i64.i.i, align 8
  %this1.i.i68.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i64.i.i, align 8
  %56 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i68.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %56, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i63.i.i, align 8
  %this1.i.i.i69.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i63.i.i, align 8
  %57 = bitcast %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i69.i.i to %"class.std::__1::allocator"*
  %58 = load i64, i64* %__cap.i.i, align 8
  %add.i.i = add i64 %58, 1
  store %"class.std::__1::allocator"* %57, %"class.std::__1::allocator"** %__a.addr.i.i.i, align 8
  store i64 %add.i.i, i64* %__n.addr.i.i.i, align 8
  %59 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %__a.addr.i.i.i, align 8
  %60 = load i64, i64* %__n.addr.i.i.i, align 8
  store %"class.std::__1::allocator"* %59, %"class.std::__1::allocator"** %this.addr.i.i58.i.i, align 8
  store i64 %60, i64* %__n.addr.i.i.i.i, align 8
  store i8* null, i8** %.addr.i.i.i.i, align 8
  %this1.i.i59.i.i = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %this.addr.i.i58.i.i, align 8
  %61 = load i64, i64* %__n.addr.i.i.i.i, align 8
  store %"class.std::__1::allocator"* %this1.i.i59.i.i, %"class.std::__1::allocator"** %this.addr.i.i.i57.i.i, align 8
  %this1.i.i.i60.i.i = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %this.addr.i.i.i57.i.i, align 8
  %62 = load i64, i64* %__n.addr.i.i.i.i, align 8
  store i64 %62, i64* %__size.addr.i.i.i.i.i, align 8
  %63 = load i64, i64* %__size.addr.i.i.i.i.i, align 8
  %call.i.i.i.i.i = call i8* @_Znwm(i64 %63) #14
  store i8* %call.i.i.i.i.i, i8** %__p.i.i, align 8
  %64 = load i8*, i8** %__p.i.i, align 8
  store %"class.std::__1::basic_string"* %this1.i5.i, %"class.std::__1::basic_string"** %this.addr.i48.i.i, align 8
  store i8* %64, i8** %__p.addr.i49.i.i, align 8
  %this1.i50.i.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i48.i.i, align 8
  %65 = load i8*, i8** %__p.addr.i49.i.i, align 8
  %__r_.i51.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i50.i.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i51.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i47.i.i, align 8
  %this1.i.i52.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i47.i.i, align 8
  %66 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i52.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %66, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i46.i.i, align 8
  %this1.i.i.i53.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i46.i.i, align 8
  %__first_.i.i.i54.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i53.i.i, i32 0, i32 0
  %67 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i54.i.i, i32 0, i32 0
  %__l.i55.i.i = bitcast %union.anon.3* %67 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"*
  %__data_.i56.i.i = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"* %__l.i55.i.i, i32 0, i32 2
  store i8* %65, i8** %__data_.i56.i.i, align 8
  %68 = load i64, i64* %__cap.i.i, align 8
  %add8.i.i = add i64 %68, 1
  store %"class.std::__1::basic_string"* %this1.i5.i, %"class.std::__1::basic_string"** %this.addr.i38.i.i, align 8
  store i64 %add8.i.i, i64* %__s.addr.i39.i.i, align 8
  %this1.i40.i.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i38.i.i, align 8
  %69 = load i64, i64* %__s.addr.i39.i.i, align 8
  %or.i.i.i = or i64 1, %69
  %__r_.i41.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i40.i.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i41.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i37.i.i, align 8
  %this1.i.i42.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i37.i.i, align 8
  %70 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i42.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %70, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i36.i.i, align 8
  %this1.i.i.i43.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i36.i.i, align 8
  %__first_.i.i.i44.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i43.i.i, i32 0, i32 0
  %71 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i44.i.i, i32 0, i32 0
  %__l.i45.i.i = bitcast %union.anon.3* %71 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"*
  %__cap_.i.i.i = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"* %__l.i45.i.i, i32 0, i32 0
  store i64 %or.i.i.i, i64* %__cap_.i.i.i, align 8
  %72 = load i64, i64* %__n.addr.i.i, align 8
  store %"class.std::__1::basic_string"* %this1.i5.i, %"class.std::__1::basic_string"** %this.addr.i28.i.i, align 8
  store i64 %72, i64* %__s.addr.i29.i.i, align 8
  %this1.i30.i.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i28.i.i, align 8
  %73 = load i64, i64* %__s.addr.i29.i.i, align 8
  %__r_.i31.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i30.i.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i31.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i27.i.i, align 8
  %this1.i.i32.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i27.i.i, align 8
  %74 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i32.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %74, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i26.i.i, align 8
  %this1.i.i.i33.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i26.i.i, align 8
  %__first_.i.i.i34.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i33.i.i, i32 0, i32 0
  %75 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i34.i.i, i32 0, i32 0
  %__l.i.i.i = bitcast %union.anon.3* %75 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"*
  %__size_.i35.i.i = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"* %__l.i.i.i, i32 0, i32 1
  store i64 %73, i64* %__size_.i35.i.i, align 8
  br label %_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2Emc.exit

_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2Emc.exit: ; preds = %if.then3.i.i, %_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE11__recommendEm.exit.i.i
  %76 = load i8*, i8** %__p.i.i, align 8
  store i8* %76, i8** %__p.addr.i.i.i, align 8
  %77 = load i8*, i8** %__p.addr.i.i.i, align 8
  %78 = load i64, i64* %__n.addr.i.i, align 8
  %79 = load i8, i8* %__c.addr.i.i, align 1
  %call11.i.i = call i8* @_ZNSt3__111char_traitsIcE6assignEPcmc(i8* %77, i64 %78, i8 signext %79) #1
  %80 = load i64, i64* %__n.addr.i.i, align 8
  %81 = load i8*, i8** %__p.i.i, align 8
  %arrayidx.i.i = getelementptr inbounds i8, i8* %81, i64 %80
  store i8 0, i8* %ref.tmp.i.i, align 1
  call void @_ZNSt3__111char_traitsIcE6assignERcRKc(i8* dereferenceable(1) %arrayidx.i.i, i8* dereferenceable(1) %ref.tmp.i.i) #1
  %__sbuf_18 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  %82 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %__sbuf_18, align 8
  store %"class.std::__1::basic_string"* %__sp, %"class.std::__1::basic_string"** %this.addr.i62, align 8
  %this1.i63 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i62, align 8
  store %"class.std::__1::basic_string"* %this1.i63, %"class.std::__1::basic_string"** %this.addr.i.i61, align 8
  %this1.i.i64 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i.i61, align 8
  store %"class.std::__1::basic_string"* %this1.i.i64, %"class.std::__1::basic_string"** %this.addr.i.i.i60, align 8
  %this1.i.i.i65 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i.i.i60, align 8
  %__r_.i.i.i66 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i.i.i65, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i.i.i66, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i.i.i59, align 8
  %this1.i.i.i.i67 = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i.i.i59, align 8
  %83 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i.i.i67 to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %83, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i.i.i58, align 8
  %this1.i.i.i.i.i68 = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i.i.i58, align 8
  %__first_.i.i.i.i.i69 = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i.i.i68, i32 0, i32 0
  %84 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i.i.i69, i32 0, i32 0
  %__s.i.i.i70 = bitcast %union.anon.3* %84 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"*
  %85 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"* %__s.i.i.i70, i32 0, i32 0
  %__size_.i.i.i71 = bitcast %union.anon.4* %85 to i8*
  %86 = load i8, i8* %__size_.i.i.i71, align 8
  %conv.i.i.i72 = zext i8 %86 to i32
  %and.i.i.i = and i32 %conv.i.i.i72, 1
  %tobool.i.i.i = icmp ne i32 %and.i.i.i, 0
  br i1 %tobool.i.i.i, label %cond.true.i.i, label %cond.false.i.i

cond.true.i.i:                                    ; preds = %_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2Emc.exit
  store %"class.std::__1::basic_string"* %this1.i.i64, %"class.std::__1::basic_string"** %this.addr.i15.i.i, align 8
  %this1.i16.i.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i15.i.i, align 8
  %__r_.i17.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i16.i.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i17.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i14.i.i, align 8
  %this1.i.i18.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i14.i.i, align 8
  %87 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i18.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %87, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i13.i.i, align 8
  %this1.i.i.i19.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i13.i.i, align 8
  %__first_.i.i.i20.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i19.i.i, i32 0, i32 0
  %88 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i20.i.i, i32 0, i32 0
  %__l.i.i.i73 = bitcast %union.anon.3* %88 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"*
  %__data_.i21.i.i = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__long"* %__l.i.i.i73, i32 0, i32 2
  %89 = load i8*, i8** %__data_.i21.i.i, align 8
  br label %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit

cond.false.i.i:                                   ; preds = %_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2Emc.exit
  store %"class.std::__1::basic_string"* %this1.i.i64, %"class.std::__1::basic_string"** %this.addr.i6.i.i, align 8
  %this1.i7.i.i = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %this.addr.i6.i.i, align 8
  %__r_.i8.i.i = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %this1.i7.i.i, i32 0, i32 0
  store %"class.std::__1::__compressed_pair.1"* %__r_.i8.i.i, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i5.i.i, align 8
  %this1.i.i9.i.i = load %"class.std::__1::__compressed_pair.1"*, %"class.std::__1::__compressed_pair.1"** %this.addr.i.i5.i.i, align 8
  %90 = bitcast %"class.std::__1::__compressed_pair.1"* %this1.i.i9.i.i to %"class.std::__1::__libcpp_compressed_pair_imp.2"*
  store %"class.std::__1::__libcpp_compressed_pair_imp.2"* %90, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i4.i.i, align 8
  %this1.i.i.i10.i.i = load %"class.std::__1::__libcpp_compressed_pair_imp.2"*, %"class.std::__1::__libcpp_compressed_pair_imp.2"** %this.addr.i.i.i4.i.i, align 8
  %__first_.i.i.i11.i.i = getelementptr inbounds %"class.std::__1::__libcpp_compressed_pair_imp.2", %"class.std::__1::__libcpp_compressed_pair_imp.2"* %this1.i.i.i10.i.i, i32 0, i32 0
  %91 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__rep"* %__first_.i.i.i11.i.i, i32 0, i32 0
  %__s.i12.i.i = bitcast %union.anon.3* %91 to %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"*
  %__data_.i.i.i74 = getelementptr inbounds %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short", %"struct.std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> >::__short"* %__s.i12.i.i, i32 0, i32 1
  %arrayidx.i.i.i75 = getelementptr inbounds [23 x i8], [23 x i8]* %__data_.i.i.i74, i64 0, i64 0
  store i8* %arrayidx.i.i.i75, i8** %__r.addr.i.i.i.i57, align 8
  %92 = load i8*, i8** %__r.addr.i.i.i.i57, align 8
  store i8* %92, i8** %__x.addr.i.i.i.i.i56, align 8
  %93 = load i8*, i8** %__x.addr.i.i.i.i.i56, align 8
  br label %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit

_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit: ; preds = %cond.true.i.i, %cond.false.i.i
  %cond.i.i = phi i8* [ %89, %cond.true.i.i ], [ %93, %cond.false.i.i ]
  store i8* %cond.i.i, i8** %__p.addr.i.i, align 8
  %94 = load i8*, i8** %__p.addr.i.i, align 8
  %95 = load i64, i64* %__ns, align 8
  store %"class.std::__1::basic_streambuf"* %82, %"class.std::__1::basic_streambuf"** %this.addr.i76, align 8
  store i8* %94, i8** %__s.addr.i77, align 8
  store i64 %95, i64* %__n.addr.i78, align 8
  %this1.i79 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i76, align 8
  %96 = bitcast %"class.std::__1::basic_streambuf"* %this1.i79 to i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)***
  %vtable.i80 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)**, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*** %96, align 8
  %vfn.i81 = getelementptr inbounds i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %vtable.i80, i64 12
  %97 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %vfn.i81, align 8
  %98 = load i8*, i8** %__s.addr.i77, align 8
  %99 = load i64, i64* %__n.addr.i78, align 8
  %call.i8283 = invoke i64 %97(%"class.std::__1::basic_streambuf"* %this1.i79, i8* %98, i64 %99)
          to label %_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl.exit unwind label %lpad

_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl.exit: ; preds = %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit
  br label %invoke.cont

invoke.cont:                                      ; preds = %_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl.exit
  %100 = load i64, i64* %__ns, align 8
  %cmp21 = icmp ne i64 %call.i8283, %100
  br i1 %cmp21, label %if.then22, label %if.end24

if.then22:                                        ; preds = %invoke.cont
  %__sbuf_23 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %__sbuf_23, align 8
  %101 = bitcast %"class.std::__1::ostreambuf_iterator"* %retval to i8*
  %102 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %101, i8* %102, i64 8, i32 8, i1 false)
  store i32 1, i32* %cleanup.dest.slot, align 4
  br label %cleanup

lpad:                                             ; preds = %_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv.exit
  %103 = landingpad { i8*, i32 }
          cleanup
  %104 = extractvalue { i8*, i32 } %103, 0
  store i8* %104, i8** %exn.slot, align 8
  %105 = extractvalue { i8*, i32 } %103, 1
  store i32 %105, i32* %ehselector.slot, align 4
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* %__sp) #1
  br label %eh.resume

if.end24:                                         ; preds = %invoke.cont
  store i32 0, i32* %cleanup.dest.slot, align 4
  br label %cleanup

cleanup:                                          ; preds = %if.end24, %if.then22
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* %__sp) #1
  %cleanup.dest = load i32, i32* %cleanup.dest.slot, align 4
  switch i32 %cleanup.dest, label %unreachable [
    i32 0, label %cleanup.cont
    i32 1, label %return
  ]

cleanup.cont:                                     ; preds = %cleanup
  br label %if.end25

if.end25:                                         ; preds = %cleanup.cont, %if.end15
  %106 = load i8*, i8** %__oe.addr, align 8
  %107 = load i8*, i8** %__op.addr, align 8
  %sub.ptr.lhs.cast26 = ptrtoint i8* %106 to i64
  %sub.ptr.rhs.cast27 = ptrtoint i8* %107 to i64
  %sub.ptr.sub28 = sub i64 %sub.ptr.lhs.cast26, %sub.ptr.rhs.cast27
  store i64 %sub.ptr.sub28, i64* %__np, align 8
  %108 = load i64, i64* %__np, align 8
  %cmp29 = icmp sgt i64 %108, 0
  br i1 %cmp29, label %if.then30, label %if.end37

if.then30:                                        ; preds = %if.end25
  %__sbuf_31 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  %109 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %__sbuf_31, align 8
  %110 = load i8*, i8** %__op.addr, align 8
  %111 = load i64, i64* %__np, align 8
  store %"class.std::__1::basic_streambuf"* %109, %"class.std::__1::basic_streambuf"** %this.addr.i44, align 8
  store i8* %110, i8** %__s.addr.i, align 8
  store i64 %111, i64* %__n.addr.i, align 8
  %this1.i45 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %this.addr.i44, align 8
  %112 = bitcast %"class.std::__1::basic_streambuf"* %this1.i45 to i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)***
  %vtable.i = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)**, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*** %112, align 8
  %vfn.i = getelementptr inbounds i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %vtable.i, i64 12
  %113 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %vfn.i, align 8
  %114 = load i8*, i8** %__s.addr.i, align 8
  %115 = load i64, i64* %__n.addr.i, align 8
  %call.i = call i64 %113(%"class.std::__1::basic_streambuf"* %this1.i45, i8* %114, i64 %115)
  %116 = load i64, i64* %__np, align 8
  %cmp33 = icmp ne i64 %call.i, %116
  br i1 %cmp33, label %if.then34, label %if.end36

if.then34:                                        ; preds = %if.then30
  %__sbuf_35 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %__s, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %__sbuf_35, align 8
  %117 = bitcast %"class.std::__1::ostreambuf_iterator"* %retval to i8*
  %118 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %117, i8* %118, i64 8, i32 8, i1 false)
  br label %return

if.end36:                                         ; preds = %if.then30
  br label %if.end37

if.end37:                                         ; preds = %if.end36, %if.end25
  %119 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %__iob.addr, align 8
  store %"class.std::__1::ios_base"* %119, %"class.std::__1::ios_base"** %this.addr.i41, align 8
  store i64 0, i64* %__wide.addr.i, align 8
  %this1.i42 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %this.addr.i41, align 8
  %__width_.i43 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %this1.i42, i32 0, i32 3
  %120 = load i64, i64* %__width_.i43, align 8
  store i64 %120, i64* %__r.i, align 8
  %121 = load i64, i64* %__wide.addr.i, align 8
  %__width_2.i = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %this1.i42, i32 0, i32 3
  store i64 %121, i64* %__width_2.i, align 8
  %122 = load i64, i64* %__r.i, align 8
  %123 = bitcast %"class.std::__1::ostreambuf_iterator"* %retval to i8*
  %124 = bitcast %"class.std::__1::ostreambuf_iterator"* %__s to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %123, i8* %124, i64 8, i32 8, i1 false)
  br label %return

return:                                           ; preds = %if.end37, %if.then34, %cleanup, %if.then12, %if.then
  %coerce.dive39 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %retval, i32 0, i32 0
  %125 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %coerce.dive39, align 8
  ret %"class.std::__1::basic_streambuf"* %125

eh.resume:                                        ; preds = %lpad
  %exn = load i8*, i8** %exn.slot, align 8
  %sel = load i32, i32* %ehselector.slot, align 4
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val40 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val40

unreachable:                                      ; preds = %cleanup
  unreachable
}

; Function Attrs: nounwind
declare void @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char, std::__1::char_traits<char> >::sentry"*) unnamed_addr #3

declare void @_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv(%"class.std::__1::ios_base"*) #5

; Function Attrs: nounwind
declare void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"*) unnamed_addr #3

; Function Attrs: noreturn
declare void @_ZNKSt3__121__basic_string_commonILb1EE20__throw_length_errorEv(%"class.std::__1::__basic_string_common"*) #10

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr i8* @_ZNSt3__111char_traitsIcE6assignEPcmc(i8* %__s, i64 %__n, i8 signext %__a) #2 comdat align 2 {
entry:
  %__s.addr = alloca i8*, align 8
  %__n.addr = alloca i64, align 8
  %__a.addr = alloca i8, align 1
  store i8* %__s, i8** %__s.addr, align 8
  store i64 %__n, i64* %__n.addr, align 8
  store i8 %__a, i8* %__a.addr, align 1
  %0 = load i64, i64* %__n.addr, align 8
  %cmp = icmp eq i64 %0, 0
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:                                        ; preds = %entry
  %1 = load i8*, i8** %__s.addr, align 8
  br label %cond.end

cond.false:                                       ; preds = %entry
  %2 = load i8*, i8** %__s.addr, align 8
  %3 = load i8, i8* %__a.addr, align 1
  %call = call i32 @_ZNSt3__111char_traitsIcE11to_int_typeEc(i8 signext %3) #1
  %4 = trunc i32 %call to i8
  %5 = load i64, i64* %__n.addr, align 8
  call void @llvm.memset.p0i8.i64(i8* %2, i8 %4, i64 %5, i32 1, i1 false)
  br label %cond.end

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i8* [ %1, %cond.true ], [ %2, %cond.false ]
  ret i8* %cond
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr void @_ZNSt3__111char_traitsIcE6assignERcRKc(i8* dereferenceable(1) %__c1, i8* dereferenceable(1) %__c2) #2 comdat align 2 {
entry:
  %__c1.addr = alloca i8*, align 8
  %__c2.addr = alloca i8*, align 8
  store i8* %__c1, i8** %__c1.addr, align 8
  store i8* %__c2, i8** %__c2.addr, align 8
  %0 = load i8*, i8** %__c2.addr, align 8
  %1 = load i8, i8* %0, align 1
  %2 = load i8*, i8** %__c1.addr, align 8
  store i8 %1, i8* %2, align 1
  ret void
}

declare void @__cxa_free_exception(i8*)

; Function Attrs: nounwind
declare void @_ZNSt12length_errorD1Ev(%"class.std::length_error"*) unnamed_addr #3

declare void @_ZNSt11logic_errorC2EPKc(%"class.std::logic_error"*, i8*) unnamed_addr #5

; Function Attrs: nobuiltin
declare noalias i8* @_Znwm(i64) #9

declare void @_ZNKSt3__18ios_base6getlocEv(%"class.std::__1::locale"* sret, %"class.std::__1::ios_base"*) #5

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #11

attributes #0 = { uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { inlinehint nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { argmemonly nounwind }
attributes #7 = { noinline noreturn nounwind }
attributes #8 = { nobuiltin nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nobuiltin "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { noreturn "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #11 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #12 = { noreturn nounwind }
attributes #13 = { builtin nounwind }
attributes #14 = { builtin }
attributes #15 = { noreturn }
attributes #16 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.9.0 (tags/RELEASE_390/final)"}
!1 = !{!2}
!2 = distinct !{!2, !3, !"_ZNKSt3__115basic_streambufIcNS_11char_traitsIcEEE6getlocEv: %agg.result"}
!3 = distinct !{!3, !"_ZNKSt3__115basic_streambufIcNS_11char_traitsIcEEE6getlocEv"}
!4 = !{!5}
!5 = distinct !{!5, !6, !"_ZNKSt3__115basic_streambufIcNS_11char_traitsIcEEE6getlocEv: %agg.result"}
!6 = distinct !{!6, !"_ZNKSt3__115basic_streambufIcNS_11char_traitsIcEEE6getlocEv"}
