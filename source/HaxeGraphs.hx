package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxColor;

/**
 * ...
 * @author lagemanngui
 */
class HaxeGraphs extends FlxState
{
	
	private var graphsGroup:FlxTypedGroup<GraphSprite>;
	public var canvasSprite:CanvasSprite;
	
	public var selectedGraph:GraphSprite;
	public var selectedGraph2:GraphSprite;
	
	public var mouseBox:FlxSprite;
	public var mouseOnGraph:Bool;
	
	
	public var id:Int = 0;

	override public function create() 
	{
		super.create();
		
		
		graphsGroup = new FlxTypedGroup<GraphSprite>();
		add(graphsGroup);
		
		mouseBox = new FlxSprite(0, 0);
		mouseBox.makeGraphic(2, 2, FlxColor.TRANSPARENT, true);
		add(mouseBox);
		
		
		canvasSprite = new CanvasSprite(0, 0);
		add(canvasSprite);
	}
	public function createNewGraph():Void
	{
		var g:GraphSprite = new GraphSprite(320, 180, id, canvasSprite);
		MouseEventManager.add(g, graphFollowMouse);
		graphsGroup.add(g);
		
		id++;
	}
	public function graphFollowMouse(g:GraphSprite):Void
	{
		selectedGraph = g;
		g.startFollowingMouse();
	}
	public function mouseRightGraph(a:FlxSprite, b:GraphSprite):Void
	{
		if (selectedGraph == null)
		{
			selectedGraph = b;
			return;
		}
		else if ( selectedGraph2 == null)
		{
			if (b.get_myId() != selectedGraph.get_myId())
			{
				selectedGraph2 = b;
			}else
			{
				return;
			}
		}
		
		canvasSprite.drawGraphTransition(selectedGraph, selectedGraph2);
		
		selectedGraph = null;
		selectedGraph2 = null;
	}
	override public function update():Void
	{
		super.update();
		
		mouseBox.x = FlxG.mouse.x;
		mouseBox.y = FlxG.mouse.y;
		
		if (FlxG.mouse.justPressedRight)
		{
			mouseOnGraph = FlxG.overlap(mouseBox, graphsGroup, mouseRightGraph);
			
			if (mouseOnGraph == false)
			{
				selectedGraph = null;
				selectedGraph2 = null;
			}
		}
		
		if (FlxG.keys.justPressed.SPACE)
		{
			createNewGraph();
		}
		
		if (FlxG.mouse.justReleased)
		{
			graphsGroup.callAll("stopFollowMouse");
			canvasSprite.updateCanvas();
		}
		
		
	}
	
}