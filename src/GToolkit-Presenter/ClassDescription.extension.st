Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Presenter' }
ClassDescription >> gtSlideBuildersAll [
	^ (GtSlidesCollector new
		from: self;
		to: self;
		collectPragmas) collect: [:eachPragma | eachPragma method gtSlideBuilder].
]

{ #category : #'*GToolkit-Presenter' }
ClassDescription >> gtSlidesAll [
	^ self gtSlideBuildersAll collect: [:each | each build].
]
