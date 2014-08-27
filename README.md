
# ![LTStackView](https://raw.githubusercontent.com/ltebean/LTStackView/master/image/demo.gif)

## Usage

Initialize a stack view by:

```objective-c
LTStackView *stackView = [[LTStackView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
stackView.dataSource = self;
```

Then implement `LTStackViewDataSource` protocol:

```objective-c
-(UIView*) nextView
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    view.backgroundColor=[UIColor blueColor];    
    return view;
}
```