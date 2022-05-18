Class {
	#name : #GtPresenterSlideStencilChanged,
	#superclass : #Announcement,
	#instVars : [
		'stencil'
	],
	#category : #'GToolkit-Presenter-Models - Events'
}

{ #category : #generated }
GtPresenterSlideStencilChanged >> stencil [
	<objectGetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ stencil
]

{ #category : #generated }
GtPresenterSlideStencilChanged >> stencil: aStencil [
	<objectSetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	stencil := aStencil
]
