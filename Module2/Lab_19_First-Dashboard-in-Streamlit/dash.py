import streamlit as st
import pandas as pd
import numpy as np
from sklearn.datasets import load_breast_cancer
import matplotlib.pyplot as plt

breast_cancer = load_breast_cancer(as_frame=True)

breast_cancer_df = pd.concat((breast_cancer["data"], breast_cancer["target"]), axis=1)

breast_cancer_df["target"] = [breast_cancer.target_names[val] for val in breast_cancer_df["target"]]

#### Set page layout as wide
st. set_page_config(layout="wide")
st.markdown('## Breast Cancer Stats') #main title

st.write(breast_cancer_df) #to view a table of data

################# Scatter Chart Plot #################
## help us understand how measurements are varying across two tumor types

#adding heading for scatter chart widgets in sidebar
st.sidebar.markdown("### Scatter Chart: Explore Relationship Between Measurements :")

measurements = breast_cancer_df.drop(labels=["target"], axis=1).columns.tolist()

#created two dropdowns using selectbox() method with a list of measurements
x_axis = st.sidebar.selectbox("X-Axis", measurements) #selects mean radius by default
y_axis = st.sidebar.selectbox("Y-Axis", measurements, index=1) #selects mean texture by second value index

#checking in if statement  that values of dropdowns are set
if x_axis and y_axis:
    scatter_fig = plt.figure(figsize=(6,4)) #to plot chart when laying out in containers

    scatter_ax = scatter_fig.add_subplot(111)
    #setting values for selected values
    malignant_df = breast_cancer_df[breast_cancer_df["target"] == "malignant"]
    benign_df = breast_cancer_df[breast_cancer_df["target"] == "benign"]
    #creating scatter chart
    malignant_df.plot.scatter(x=x_axis, y=y_axis, s=120, c="tomato", alpha=0.6, ax=scatter_ax, label="Malignant")
    benign_df.plot.scatter(x=x_axis, y=y_axis, s=120, c="dodgerblue", alpha=0.6, ax=scatter_ax,
                           title="{} vs {}".format(x_axis.capitalize(), y_axis.capitalize()), label="Benign");

########## Bar Chart Logic ##################
## showing the value of the average measurements per tumor type

#adding markdown for multi-select in the sidebar
st.sidebar.markdown("### Bar Chart: Average Measurements Per Tumor Type : ")
#creates avg measurements dataframe
avg_breast_cancer_df = breast_cancer_df.groupby("target").mean()
#creating multi-select
bar_axis = st.sidebar.multiselect(label="Average Measures per Tumor Type Bar Chart",
                                  options=measurements, #list to use as option
                                  default=["mean radius","mean texture", "mean perimeter", "area error"]) #list of default values
#if-else based on returned values by multi-select
if bar_axis: #if some options are selected then executes and creates bar chart 
    bar_fig = plt.figure(figsize=(6,4))

    bar_ax = bar_fig.add_subplot(111)

    sub_avg_breast_cancer_df = avg_breast_cancer_df[bar_axis]

    sub_avg_breast_cancer_df.plot.bar(alpha=0.8, ax=bar_ax, title="Average Measurements per Tumor Type");

else: #if none of the options are selected executes with default values
    bar_fig = plt.figure(figsize=(6,4))

    bar_ax = bar_fig.add_subplot(111)

    sub_avg_breast_cancer_df = avg_breast_cancer_df[["mean radius", "mean texture", "mean perimeter", "area error"]]

    sub_avg_breast_cancer_df.plot.bar(alpha=0.8, ax=bar_ax, title="Average Measurements per Tumor Type");

################# Histogram Logic ########################
## useful to analyze how values of measurements are spread

# adding markdown in the sidebar above widgets 
st.sidebar.markdown("### Histogram: Explore Distribution of Measurements : ")

#create 2 widgets for a histogram
# one is multi-select with a list of measurements, by default mean radius, mean texture
hist_axis = st.sidebar.multiselect(label="Histogram Ingredient", options=measurements, default=["mean radius", "mean texture"])
#radio buttons with values in the range 10-50, b default 50
bins = st.sidebar.radio(label="Bins :", options=[10,20,30,40,50], index=4)

#if-else based on a list of selected options in multi-section
if hist_axis: #if options are selected, create a hist of selected options
    hist_fig = plt.figure(figsize=(6,4))

    hist_ax = hist_fig.add_subplot(111)

    sub_breast_cancer_df = breast_cancer_df[hist_axis]
    #bins of hist will be set based on radio buttons
    sub_breast_cancer_df.plot.hist(bins=bins, alpha=0.7, ax=hist_ax, title="Distribution of Measurements");
else: #if not selected, create a hist of the 2 default values
    hist_fig = plt.figure(figsize=(6,4))

    hist_ax = hist_fig.add_subplot(111)

    sub_breast_cancer_df = breast_cancer_df[["mean radius", "mean texture"]]
    #bins of hist will be set based on radio buttons
    sub_breast_cancer_df.plot.hist(bins=bins, alpha=0.7, ax=hist_ax, title="Distribution of Measurements");

#################### Hexbin Chart Logic ##################################
## useful to show a relationship between two attributes explaining the density of samples

#adding markdown heading in the sidebar above widgets
st.sidebar.markdown("### Hexbin Chart: Explore Concentration of Measurements :")
#creates 2 dropdowns with a list of measurements
hexbin_x_axis = st.sidebar.selectbox("Hexbin-X-Axis", measurements, index=0) #select X axis
hexbin_y_axis = st.sidebar.selectbox("Hexbin-Y-Axis", measurements, index=1) #select Y axis

#plot hexbin using selected values through dropdowns
if hexbin_x_axis and hexbin_y_axis:
    hexbin_fig = plt.figure(figsize=(6,4))

    hexbin_ax = hexbin_fig.add_subplot(111)

    breast_cancer_df.plot.hexbin(x=hexbin_x_axis, y=hexbin_y_axis,
                                 reduce_C_function=np.mean,
                                 gridsize=25,
                                 #cmap="Greens",
                                 ax=hexbin_ax, title="Concentration of Measurements")

##################### Layout Application ##################

#create page-wide container
container1 = st.container()
col1, col2 = st.columns(2) #create 2 containers of equal length inside container

#then used a container object and column container objects as a context manager (with statement)
with container1:
    with col1: #inside column of container
        scatter_fig #adds scatter chart
    with col2:
        bar_fig #add bar chart

#same logic for second container
container2 = st.container()
col3, col4 = st.columns(2)

with container2:
    with col3:
        hist_fig #add histogram
    with col4:
        hexbin_fig #add hexbin