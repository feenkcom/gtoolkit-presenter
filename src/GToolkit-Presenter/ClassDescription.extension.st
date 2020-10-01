Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Presenter' }
ClassDescription >> gtSlidesAll [
	^ (GtSlidesCollector new
		from: self;
		to: self;
		collectPragmas) collect: [:eachPragma | eachPragma method gtSlide].
]
