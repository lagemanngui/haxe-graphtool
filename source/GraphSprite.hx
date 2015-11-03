package;
import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author lagemanngui
 */
class GraphSprite extends FlxSprite
{
	
	private var _name:String;
	private var _followMouse:Bool = false;
	private var _canvas:CanvasSprite;
	private var _myId:Int;

	public function new(X:Float, Y:Float, MYID:Int, CANVAS:CanvasSprite) 
	{
		super(X, Y);
		
		_myId = MYID;
		
		_canvas = CANVAS;
		
		makeGraphic(32, 32);
	}
	public function get_myId():Int
	{
		return _myId;
	}
	public function startFollowingMouse():Void
	{
		_followMouse = true;
	}
	public function followMouse():Void
	{
		x = FlxG.mouse.x-16;
		y = FlxG.mouse.y - 16;
		
		_canvas.updateCanvas();
	}
	public function stopFollowMouse():Void
	{
		_followMouse = false;
	}
	override public function update():Void
	{
		super.update();
		
		
		if (_followMouse)
		{
			followMouse();
		}
		
	}
}