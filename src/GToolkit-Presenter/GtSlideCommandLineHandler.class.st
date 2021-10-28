Class {
	#name : #GtSlideCommandLineHandler,
	#superclass : #GtExamplesCommandLineHandler,
	#category : 'GToolkit-Presenter-Runtime'
}

{ #category : #accessing }
GtSlideCommandLineHandler class >> commandName [
	^ 'slides'
]

{ #category : #accessing }
GtSlideCommandLineHandler class >> description [
	^ 'A command line runner for slides'.
]

{ #category : #accessing }
GtSlideCommandLineHandler >> exampleReport [
	(self hasOption: 'junit-xml-output') ifTrue: [ ^ GtSlidesHudsonReport ].
	^ self error: 'only works for now for junit for now'
]
