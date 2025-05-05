"
I show some typical examples of how to create slides.

```
GtSlideShowExamples new openInSpace
```


"
Class {
	#name : #GtSlideShowExamples,
	#superclass : #GtSlideShowStencil,
	#category : #'GToolkit-Presenter-Examples'
}

{ #category : #accessing }
GtSlideShowExamples >> create [
	| show |
	show := GtSlideShow new.
	show
		addSlide: (GtTitleLiveSlide new titleWithFormat: (self title: 'Title slide')).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (self heading: 'Slide with Text and Playground snippets.');
				newText: 'You can adjust the space for the element between 0 and 1.';
				element: [ GtPlaygroundLiveSlide new
						snippets: {'3 + 4' . '''Hello world'''};
						asElement ];
				elementWeight: 0.6).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (self heading: 'Embedding a full Class Coder');
				element: [ (GtCoderElement forClass: Boolean) createInPager maximized ];
				elementWeight: 0.6).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (self heading: 'Coder with a given method expanded');
				element: [ (GtCoderElement forMethod: True >> #ifTrue:ifFalse:) createInPager
					"maximized" ];
				elementWeight: 0.6).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (self heading: 'A Method coder for selected methods');
				element: [ self
						methodCoderForMethods:
							{(Boolean >> #not).
							(True >> #not).
							(False >> #not)} ]).
	show
		addSlide:
			(GtTextAndElementLiveSlide new
				newTextWithFormat: (self heading: 'New method definitions');
				newText:
					'These method definitions must be accepted before they will be compiled.';
				element: [ self
						methodCoderForClass: Object
						withSources: {'foo ^ ''foo''' . 'bar ^ ''bar'''} ];
				elementWeight: 0.6).
	show
		addSlide:
			(GtLabelAndElementLiveSlide new
				newTextWithFormat: (self heading: 'A Class Hierarchy');
				newText: 'Note that diagram is live, so you can click on the classes.';
				element: [ (GtPager
						createWrappedOn:
							(GtInspectorTool
								forObject:
									(GtMondrianDomainExamples new
										classHierarchyFor: Boolean withAllSubclasses)
								viewSelector: #gtLiveFor:)) maximized ]).
	show
		addSlide:
			(GtLabelAndElementLiveSlide new
				newTextWithFormat: (self heading: 'A full Inspector');
				newText: 'This example  shows how to embed a full Inspector on a given object.';
				element: [ (GtInspector createOn: Boolean) maximized ]).
	show
		addSlide:
			(GtLabelAndElementLiveSlide new
				newTextWithFormat: (self heading: 'A GtExample');
				newText:
					'The example below shows an address book with multiple categories and contacts.'
						asRopedText;
				element: [ GtExampleLiveSlide new
						method: GtABAddressBookExample >> #contactsAddressBookWithCategories;
						asElement ]).
	show makeArrowsVisible.
	^ show
]

{ #category : #accessing }
GtSlideShowExamples >> exampleSlideShow [
	"Or better: GtSlideShowExamples new openInSpace"

	<gtExample>
	<return: #GtSlideShow>
	^ self create
]

{ #category : #accessing }
GtSlideShowExamples >> exampleSlideShowInScripter [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := BlScripter new.
	aScripter element: self exampleSlideShow asElement.

	^ aScripter
]
