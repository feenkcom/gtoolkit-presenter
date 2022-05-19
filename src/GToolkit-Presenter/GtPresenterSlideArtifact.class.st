Class {
	#name : #GtPresenterSlideArtifact,
	#superclass : #Object,
	#instVars : [
		'slidePreview',
		'slideElement'
	],
	#category : #'GToolkit-Presenter-Models'
}

{ #category : #'gt-extension' }
GtPresenterSlideArtifact >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		priority: 5;
		stencil: [ self slidePreview asElement ]
]

{ #category : #accessing }
GtPresenterSlideArtifact >> slideElement [

	^ slideElement
]

{ #category : #initialization }
GtPresenterSlideArtifact >> slideElement: anElement preview: aForm [
	slideElement := anElement.
	slidePreview := aForm
]

{ #category : #accessing }
GtPresenterSlideArtifact >> slidePreview [

	^ slidePreview
]
