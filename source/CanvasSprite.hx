package;
import flixel.FlxSprite;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author lagemanngui
 */
class CanvasSprite extends FlxSprite
{
	public var drawingTransitions:Array<Array<GraphSprite>> = [[]];
	private var timer:Int = 60;

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		
		makeGraphic(640, 480, FlxColor.TRANSPARENT, true);
		
	}
	public function drawGraphTransition(a:GraphSprite, b:GraphSprite):Void
	{
		
		
		drawingTransitions.push([a, b]);
		
		updateCanvas();
	}
	public function updateCanvas():Void
	{
		this.fill(FlxColor.TRANSPARENT);
			
			for (_arr in drawingTransitions)
			{
				if (_arr.length > 0)
				{
					this.drawLine( _arr[0].x + 16, _arr[0].y + 16, _arr[1].x + 16,  _arr[1].y + 16, {thickness:2, color:0xffffffff});
				}
			}
	}
	override public function update():Void
	{
		super.update();
		
		if (timer <= 0)
		{
			updateCanvas();
			timer = 60;
		}else
		{
			timer--;
		}
		
		
	}
	
	
}