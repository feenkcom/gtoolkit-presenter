Class {
	#name : #GtNewSlideArtifact,
	#superclass : #Object,
	#instVars : [
		'slidePreview',
		'slideElement'
	],
	#category : #'GToolkit-Presenter-Model'
}

{ #category : #'gt-extension' }
GtNewSlideArtifact >> gtPreviewFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Preview';
		priority: 5;
		stencil: [ self slidePreview asElement ]
]

{ #category : #accessing }
GtNewSlideArtifact >> slideElement [

	^ slideElement
]

{ #category : #initialization }
GtNewSlideArtifact >> slideElement: anElement preview: aForm [
	slideElement := anElement.
	slidePreview := aForm
]

{ #category : #accessing }
GtNewSlideArtifact >> slidePreview [

	^ slidePreview
]
