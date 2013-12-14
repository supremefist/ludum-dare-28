import haxe.unit.TestRunner;

class TestMain
{
	public static function main()
	{
		var r = new TestRunner();
		var testAll:Bool = true;
		
		if (testAll) {
			r.add(new TestTemplate());
		}
		
		var success:Bool = r.run();
	}
}