
# YHPDFImageLoader ![](http://git.oschina.net/NSLogHeng/imageFiles/raw/master/codeAvatar.png)


### 一个用于在iOS项目中高效加载PDF矢量图标(尺寸可以无限放大)的工具。
####在 pod 中集成方法
* 在 Podfile 文件中添加:

		pod 'YHPDFImageLoader'
	
* 执行 pod install 命令
	
####如何使用

* 第一步：

```
	 #import "UIImage+YHPDFIcon.h"
```

* 第二步：

```
	 UIImage *image = [UIImage yh_imageNamed:@"pdfName"];
```
* That‘s all.
* 

####效果展示（源文件图片分辨率为 30x46 ，大小为 8KB）

![](http://git.oschina.net/NSLogHeng/imageFiles/raw/master/YHPDFImageLoader/YHPDFImageLoader-demoGif.gif)


##更多使用方法请参照项目中 Demo。


<br /><br /><br />
- - - -
####补充：相关简介
我们知道在 Xcode 6 及以上版本可以在 Asset Catalog 中使用 PDF 格式的矢量图资源。

```
【引用】
	 大致上，PDF是矢量元素的事实标准。矢量文件包含一个元素的很多元数据，用来告诉系统如何渲染这些内容，而这些和屏幕分辨率无关。举个通俗易懂例子，一个圆形的矢量PDF图，当它渲染成5像素宽和渲染成5000000像素宽时是一样清晰的。

在iOS平台，Xcode是在编译时，根据你的矢量PDF图的大小，生成1x、2x和3x图。如果你的PDF图是45*45px，那么Xcode会在编译时生成下面3个PNG：

	45*45px      ：1x设备用的(iPhone 3G and 3GS)
	90*90px      ：2x或Retina显示设备用的(iPhone 4, 4S, 5, 5S, and 6)
	135*135px    ：3x设备用的(iPhone 6 Plus 及以上)
	
这也意味着当有更高的屏幕分辨率时，Xcode可以根据已有的矢量PDF放大图片，这样自动就支持以后的设备了。还有，如果你是OS X开发者，那么矢量PDF就更好用了，OS X app完全支持矢量PDF，你可以用代码缩放图片而不会失真。
```
[想了解上述全部内容请猛戳传送门：4个你需要知道的Asset Catalog的秘密](http://www.cocoachina.com/ios/20151102/14009.html)


##### 使用 PDF 作为图标素材资源具有如下优点：
		
1. APP 瘦身
	
	我们对比一下最近设计部门的朋友刚导出的某个图标的一套常规的 PNG 图片和 PDF 类型的图片的大小：
	
	![](http://git.oschina.net/NSLogHeng/imageFiles/raw/master/YHPDFImageLoader/comparison-pdf-png.png)
	
	PDF 文件大小为 7KB
	
	PNG 三个文件合计大小为 85KB
	
	对比结果: PDF 类型的文件大概占空间为传统 PNG 类型的 8%（以当前资源为依据，不同资源对比结果可能会有部分出入）。
	
2. 便于维护
	
	首先就是设计部门出图就会比之前方便很多，直接导出矢量文件即可，并且如果后期再需要 4X、5X... 规格的图，不需要对之前的图标再返工处理。 
	
	再者作为开发者在管理图片相关的添加、替换、移除等重复性的操作维护压力可以降低。
	
3. 可以无限放大
	
	由于 PDF 图标文件为矢量图，不同于之前的传统的位图，在放大之后可以依然保持清晰而非模糊毛边有像素颗粒感。  

	例如，后期需求调整要求某一个按钮交互热区变大，相应图标也要放大。如果使用之前 PNG 类型的资源，需要设计重新再出一套图（作为一个严谨的程序员，当然不能够容忍模糊图标的存在🙃），但无形中这些都是开发过程中的时间成本。

	想想如果使用 PDF 类型的资源直接改变一下图标大小不就可以了吗？那就直接行动，但是最后发现在 Asset Catalog 就算使用了 PDF 类型的图放大后还是模糊了。为什么呢？原来Xcode在编译的时候只是依据目前设备所需要的资源只自动生成1X、2X和3X规格的位图类型的图片，那么在后期通过只改变控件的大小来希望图片精度也动态的调整自然是行不通了。

	由此就产生了 **[YHPDFImageLoader](https://github.com/jiisd/YHPDFImageLoader)** 这个工具，它旨在解决上述后期动态调整放大图片发虚的问题，与系统调用加载图片兼容，并具有三级加载两级缓存功能，以减少重复性质的运算并提高加载效率,下面是一张加载效果对比图：	
	![](http://git.oschina.net/NSLogHeng/imageFiles/raw/master/YHPDFImageLoader/magnify.png)


当然，使用 **[YHPDFImageLoader](https://github.com/jiisd/YHPDFImageLoader)** 依然可以使用 .bundle 资源文件包或者文件夹的形式管理 PDF 素材资源（虽然苹果声称使用 Asset Catalog 后 APP 的相关资源可以有效的防盗，但是目前仍可轻而易举的提取出里面的内容）。

还在等什么，赶紧 **[点击下载](https://github.com/jiisd/YHPDFImageLoader)** 集成进你的项目中和你的设计小伙伴们更愉快的玩耍吧。
