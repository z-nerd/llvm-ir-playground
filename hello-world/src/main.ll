; Declare the printf function
declare i32 @printf(ptr, ...)

; Define a global string constant for the message
@.str = private unnamed_addr constant [15 x i8] c"Hello, World!\0A\00", align 1

; Define the main function
define i32 @main() {
  ; Get a pointer to the global string
  %fmt = getelementptr inbounds [15 x i8], ptr @.str, i32 0, i32 0

  ; Call printf with the format string
  call i32 (ptr, ...) @printf(ptr %fmt)

  ; Return 0 from main
  ret i32 0
}
