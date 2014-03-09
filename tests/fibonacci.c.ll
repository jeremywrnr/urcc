; ModuleID = '<stdin>'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@array = common global [32 x i32] zeroinitializer, align 16
@.str = private unnamed_addr constant [53 x i8] c"The first few digits of the Fibonacci sequence are:\0A\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @initialize_array() #0 {
entry:
  %idx = alloca i32, align 4
  %bound = alloca i32, align 4
  %"reg2mem alloca point" = bitcast i32 0 to i32
  store i32 32, i32* %bound, align 4
  store i32 0, i32* %idx, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i32* %idx, align 4
  %1 = load i32* %bound, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i32* %idx, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds [32 x i32]* @array, i32 0, i64 %idxprom
  store i32 -1, i32* %arrayidx, align 4
  %3 = load i32* %idx, align 4
  %add = add nsw i32 %3, 1
  store i32 %add, i32* %idx, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @fib(i32 %val) #0 {
entry:
  %retval = alloca i32, align 4
  %val.addr = alloca i32, align 4
  %"reg2mem alloca point" = bitcast i32 0 to i32
  store i32 %val, i32* %val.addr, align 4
  %0 = load i32* %val.addr, align 4
  %cmp = icmp slt i32 %0, 2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %1 = load i32* %val.addr, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds [32 x i32]* @array, i32 0, i64 %idxprom
  %2 = load i32* %arrayidx, align 4
  %cmp1 = icmp eq i32 %2, -1
  br i1 %cmp1, label %if.then2, label %if.end.if.end7_crit_edge

if.end.if.end7_crit_edge:                         ; preds = %if.end
  br label %if.end7

if.then2:                                         ; preds = %if.end
  %3 = load i32* %val.addr, align 4
  %sub = sub nsw i32 %3, 1
  %call = call i32 @fib(i32 %sub)
  %4 = load i32* %val.addr, align 4
  %sub3 = sub nsw i32 %4, 2
  %call4 = call i32 @fib(i32 %sub3)
  %add = add nsw i32 %call, %call4
  %5 = load i32* %val.addr, align 4
  %idxprom5 = sext i32 %5 to i64
  %arrayidx6 = getelementptr inbounds [32 x i32]* @array, i32 0, i64 %idxprom5
  store i32 %add, i32* %arrayidx6, align 4
  br label %if.end7

if.end7:                                          ; preds = %if.end.if.end7_crit_edge, %if.then2
  %6 = load i32* %val.addr, align 4
  %idxprom8 = sext i32 %6 to i64
  %arrayidx9 = getelementptr inbounds [32 x i32]* @array, i32 0, i64 %idxprom8
  %7 = load i32* %arrayidx9, align 4
  store i32 %7, i32* %retval
  br label %return

return:                                           ; preds = %if.end7, %if.then
  %8 = load i32* %retval
  ret i32 %8
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %idx = alloca i32, align 4
  %bound = alloca i32, align 4
  %"reg2mem alloca point" = bitcast i32 0 to i32
  store i32 0, i32* %retval
  store i32 32, i32* %bound, align 4
  call void @initialize_array()
  store i32 0, i32* %idx, align 4
  %call = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([53 x i8]* @.str, i32 0, i32 0))
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i32* %idx, align 4
  %1 = load i32* %bound, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %2 = load i32* %idx, align 4
  %call1 = call i32 @fib(i32 %2)
  %call2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0), i32 %call1)
  %3 = load i32* %idx, align 4
  %add = add nsw i32 %3, 1
  store i32 %add, i32* %idx, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %4 = load i32* %retval
  ret i32 %4
}

declare i32 @printf(i8*, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf"="true" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "unsafe-fp-math"="false" "use-soft-float"="false" }
