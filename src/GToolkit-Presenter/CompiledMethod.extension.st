Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Presenter' }
CompiledMethod >> gtSlide [
	^ thisContext
		object: self methodClass new
		perform: self selector
		withArguments: {GtEmptySlide new}
		inClass: self methodClass.
]
