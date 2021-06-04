"
I offer a few utility methods that can be useful for creating slideshows.

See my subclass, {{gtClass:name=GtSlideShowExamples}}.


"
Class {
	#name : #GtSlideShowStencil,
	#superclass : #BrStencil,
	#category : #'GToolkit-Presenter-Examples-GToolkit-Presenter-Examples'
}

{ #category : #accessing }
GtSlideShowStencil >> defaultHeadingSize [
^ 36
]

{ #category : #accessing }
GtSlideShowStencil >> defaultSubtitleSize [
	^ 50
]

{ #category : #accessing }
GtSlideShowStencil >> defaultTitleSize [
	^ 70
]

{ #category : #accessing }
GtSlideShowStencil >> heading: aString [
	^ aString asRopedText fontSize: self defaultHeadingSize
]

{ #category : #accessing }
GtSlideShowStencil >> methodCoderForClass: aClass withSource: methodSource [
	^ self methodCoderForClass: aClass withSources: {methodSource}
]

{ #category : #accessing }
GtSlideShowStencil >> methodCoderForClass: aClass withSources: methodSourceCollection [
	| container |
	container := BlElement new.
	container layout: BlLinearLayout vertical alignCenter.
	methodSourceCollection
		do: [ :methodSource | 
			container
				addChild:
					((GtPharoMethodCoder
						forClass: aClass
						source: (OpalCompiler new format: methodSource)) asCoderUIModel
						expanded: true;
						asElement) ].
	^ container
]

{ #category : #accessing }
GtSlideShowStencil >> methodCoderForMethod: aMethod [
	^ self methodCoderForMethods: {aMethod}
]

{ #category : #accessing }
GtSlideShowStencil >> methodCoderForMethods: aMethodList [
	| container |
	container := BlElement new.
	container layout: BlLinearLayout vertical alignCenter.
	aMethodList
		do: [ :aMethod | 
			container
				addChild: ((GtPharoMethodCoder forMethod: aMethod) asCoderUIModel expanded: true) asElement ].
	^ container
]

{ #category : #accessing }
GtSlideShowStencil >> methodSourceWithoutInspectorFor: aMethod [
	^ GtPager
		createWrappedOn: ((aMethod gtSourceFor: GtPhlowView empty) asElementDo: [ :e | e ])
]

{ #category : #accessing }
GtSlideShowStencil >> openInSpace [
	self openSlideshowInNewSpace: (self create)
]

{ #category : #accessing }
GtSlideShowStencil >> openSlideshowInNewSpace: aSlideshow [
	BlSpace new
		title: 'Space';
		extent: 1200 @ 600;
		addChild: aSlideshow makeArrowsVisible create;
		withHalos;
		show
]

{ #category : #accessing }
GtSlideShowStencil >> subtitle: aString [
	^ aString asRopedText
		fontSize: self defaultSubtitleSize;
		foreground: Color gray
]

{ #category : #accessing }
GtSlideShowStencil >> title: aString [
	^ aString asRopedText fontSize: self defaultTitleSize
]
