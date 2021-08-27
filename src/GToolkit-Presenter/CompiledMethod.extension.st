Extension { #name : 'CompiledMethod' }

{ #category : '*GToolkit-Presenter' }
CompiledMethod >> gtSlide [
	<gtCollector>
	^ thisContext
		object: self methodClass new
		perform: self selector
		withArguments: {GtEmptySlide new}
		inClass: self methodClass.
]

{ #category : '*GToolkit-Presenter' }
CompiledMethod >> gtSlideBuilder [
	^ GtSlideBuilder new
		slideShowClass: self methodClass;
		slideSelector: self selector
]
