# ConvenientModels
平时看到的一些不错效果, 我会在这个项目中做成 Demos, 包括模仿, 包括原创, 但是我会尊重原创, 会在原创的 Demo 中备注对应的出处.

## 1、 DWAnimatedLabel
1、 **DWAnimatedLabel** 的思想是: 选择 **CADisplayLink** 而不是 **NSTimer** 来对 view 进行重绘动画. `CADisplayLink` 和 `NSTimer` 都需要注册到 RunLoop 中, 前者在屏幕需要重新绘制时会让 RunLoop 调用 `CADisplayLink` 指定的 selector, 用于准备下一帧显示的数据; 后者 `NSTimer` 是需要在上一次 RunLoop 整个完成之后才会调用其 selector, `NSTimer` 所处的 Runloop 中要处理多种不同的输入, 导致 timer 的最小周期是 50 到 100 毫秒之间, 一秒钟之内最多只能跑 20 次左右. 流畅的动画维持在60帧的刷新频率, 即每一帧的刷新时间是 1/60 (秒/帧)

   注意两个属性 `timeInteval` 和 `frameInterval`. timeInteval 对应的是 NSTimer的 selector 调用间隔, 但是如果 `NSTimer` 的触发时间到了, 而 RunLoop 处于阻塞状态, 其出发时间就会推迟到下一个 RunLoop. 而 `CADisplayLink` 的 timer 间隔是不能调整的, 固定是一秒钟发生 **60** 次. 不过可以设置 frameInterval 属性(注意: 在 iOS10 中已经弃用, 使用 `perferredFramesPerSecond`), 设置调用一次 selector 之间的间隔帧数. 如果 selector 执行的代码超过了 frameInterval 的持续时间, 那么 `CADisplayLink` 就会**直接忽略**这一帧, 在下一次的更新时候再接着运行
   
2、 DWAnimatedLabel 的效果有: 打字机效果, 闪烁效果, 渐变效果, 波纹进度效果. 具体实现这里不过多叙述, 详情请看逻辑

3、 原创链接:    
[使用CADisplayLink实现UILabel动画特效](https://dywane.github.io/使用CADisplayLink实现UILabel动画特效/)

4、推荐阅读:    
[RQShineLabel](https://github.com/zipme/RQShineLabel)    
[CADisplayLink 官方文档](https://developer.apple.com/documentation/quartzcore/cadisplaylink)    
[CoreAnimation](https://zsisme.gitbooks.io/ios-/content/chapter11/frame-timing.html)
