package com.merlinds.unitls
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Check for the inheritance of the class.
	 * 
	 * @param target Class for checking
	 * @param expectsClasses Class that <code>target</code> must extended,
	 * if null checker will be ignored it
	 * @param implementsInterfaces Interfaces that <code>target</code> must implemented, 
	 * if null checker will be ignored it
	 * 
	 * @return True if class extended <code>expectedClass</code> and implements <code>implementsInterfaces</code>.
	 * In other case return false.
	 * 
	 */
	public function inheritanceCheck(target:Class, expectedClass:Class = null,
									 ...implementsInterfaces):Boolean
	{
		var necessaryElement:String;
		var factory:XMLList = describeType( target ).factory;
		//Check for the right super extended
		if(expectedClass)
		{
			necessaryElement = getQualifiedClassName( expectedClass );
			var searchElement:XMLList = factory.extendsClass.(@type == necessaryElement);
			if(!searchElement.length())return false;
		}
		//Check for interfaces implementation
		if(implementsInterfaces)
		{
			var length:int = implementsInterfaces.length;
			for(var i:int = 0; i < length; i++)
			{
				necessaryElement = getQualifiedClassName( implementsInterfaces[i] );
				searchElement = factory.implementsInterface.(@type == necessaryElement);
				if(!searchElement.length())return false;
			}
		}
		//All right class extended right super and implemented necessary interfaces
		return true;
	}
}