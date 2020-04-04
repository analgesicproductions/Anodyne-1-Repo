package org.flixel.system 
{
    /**
     * ...
     * @author moly
     */
    internal class ObjectPool
    {
        protected var _objects:Array;
        protected var _objectClass:Class;
	
        public function ObjectPool(ObjectClass:Class)
        {
            _objectClass = ObjectClass;
            _objects = new Array();
        }
	
        public function getNew():*
        {
            var object:* = null;
            if (_objects.length > 0)
                object = _objects.pop();
            else
                object = new _objectClass();
            return object;
        }
	
        public function disposeObject(OldObject:Object):void
        {
            _objects.push(OldObject);
        }
    }
}