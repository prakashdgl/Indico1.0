// This file is generated by CodeSmith. Do not edit. All edits to this file will be lost. 
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Reflection;
using System.Xml.Serialization;

//using Indico.BusinessObjects.Util;
//using Indico.BusinessObjects;
using Indico.DAL;


namespace Indico.BusinessObjects
{
    /// <summary>
    /// HSCodeDetailsBO provides the business logic for maintaining Indico.DAL.HSCodeDetails records in the data store.
    /// </summary>
    /// <remarks>
    /// HSCodeDetailsBO provides the business logic for maintaining Indico.DAL.HSCodeDetails records in the data store. 
    /// By default it provides basic Search methods for retrieving Indico.DAL.HSCodeDetails
    /// records using the HSCodeDetails DAL class. Other methods implement atomic chunks of Business Logic according to
    /// the business rules.
    /// </remarks>
    public partial class HSCodeDetailsBO : BusinessObject, IComparable
    {
        #region fields
        private int? _hSCode;
        private int? _itemSubCategoryID;
        private string _itemSubCategory;
        private int? _genderID;
        private string _gender;
        private string _code;
        #endregion
        
        #region Properties
        /// <summary></summary>
        public int? HSCode
        {   get {return _hSCode;}
            set 
            {
                _hSCode = value;
            }
        }
        /// <summary></summary>
        public int? ItemSubCategoryID
        {   get {return _itemSubCategoryID;}
            set 
            {
                _itemSubCategoryID = value;
            }
        }
        /// <summary></summary>
        public string ItemSubCategory
        {   get {return _itemSubCategory;}
            set 
            {
                _itemSubCategory = value;
            }
        }
        /// <summary></summary>
        public int? GenderID
        {   get {return _genderID;}
            set 
            {
                _genderID = value;
            }
        }
        /// <summary></summary>
        public string Gender
        {   get {return _gender;}
            set 
            {
                _gender = value;
            }
        }
        /// <summary></summary>
        public string Code
        {   get {return _code;}
            set 
            {
                _code = value;
            }
        }
        #endregion
        
        #region Internal Constructors
        /// <summary>
        /// Creates an instance of the HSCodeDetailsBO class using the supplied Indico.DAL.HSCodeDetails. 
        /// </summary>
        /// <param name="obj">a Indico.DAL.HSCodeDetails whose properties will be used to initialise the HSCodeDetailsBO</param>
        internal HSCodeDetailsBO(Indico.DAL.HSCodeDetails obj)
        {
            // set the properties from the Indico.DAL.HSCodeDetails 
            this.HSCode = obj.HSCode;
            this.ItemSubCategoryID = obj.ItemSubCategoryID;
            this.ItemSubCategory = obj.ItemSubCategory;
            this.GenderID = obj.GenderID;
            this.Gender = obj.Gender;
            this.Code = obj.Code;
        }
        #endregion
        
        #region Internal utility methods
        internal void SetDAL(Indico.DAL.HSCodeDetails obj, IndicoEntities context)
        {
            // set the Indico.DAL.HSCodeDetails properties
            obj.HSCode = Convert.ToInt32(HSCode);
            obj.ItemSubCategoryID = Convert.ToInt32(ItemSubCategoryID);
            obj.ItemSubCategory = ItemSubCategory;
            obj.GenderID = Convert.ToInt32(GenderID);
            obj.Gender = Gender;
            obj.Code = Code;
        }
        
        internal void SetBO(Indico.DAL.HSCodeDetails obj)
        {
            // set the Indico.BusinessObjects.HSCodeDetailsBO properties    
            this.HSCode = obj.HSCode;
            this.ItemSubCategoryID = obj.ItemSubCategoryID;
            this.ItemSubCategory = obj.ItemSubCategory;
            this.GenderID = obj.GenderID;
            this.Gender = obj.Gender;
            this.Code = obj.Code;
        }
        
        internal void SetBO(Indico.BusinessObjects.HSCodeDetailsBO obj)
        {
            // set this Indico.BusinessObjects.HSCodeDetailsBO properties
            this.HSCode = obj.HSCode;
            this.ItemSubCategoryID = obj.ItemSubCategoryID;
            this.ItemSubCategory = obj.ItemSubCategory;
            this.GenderID = obj.GenderID;
            this.Gender = obj.Gender;
            this.Code = obj.Code;
        }
        
        private static List<Indico.BusinessObjects.HSCodeDetailsBO> IQueryableToList(IQueryable<Indico.DAL.HSCodeDetails> oQuery)
        {
            List<Indico.DAL.HSCodeDetails> oList = oQuery.ToList();
            List<Indico.BusinessObjects.HSCodeDetailsBO> rList = new List<Indico.BusinessObjects.HSCodeDetailsBO>(oList.Count);
            foreach (Indico.DAL.HSCodeDetails o in oList)
            {
                Indico.BusinessObjects.HSCodeDetailsBO obj = new Indico.BusinessObjects.HSCodeDetailsBO(o);
                rList.Add(obj);
            }
            return rList;
        }
        #endregion
        
        #region BusinessObject methods
        
        #region GetAllObject
        public static List<Indico.BusinessObjects.HSCodeDetailsBO> GetAllObject()
        {
            return GetAllObject(0, 0);
        }
        public static List<Indico.BusinessObjects.HSCodeDetailsBO> GetAllObject(int maximumRows)
        {
            return GetAllObject(maximumRows, 0);
        }
        public static List<Indico.BusinessObjects.HSCodeDetailsBO> GetAllObject(int maximumRows, int startIndex)
        {
            return GetAllObject(maximumRows, startIndex, null, false);
        }
        public static List<Indico.BusinessObjects.HSCodeDetailsBO> GetAllObject(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.HSCodeDetails> oQuery =
                (from o in context.HSCodeDetails
                 orderby o.HSCode
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.HSCode).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.HSCodeDetailsBO> hscodedetailss = IQueryableToList(oQuery);
            context.Dispose();
            return hscodedetailss;
        }
        #endregion
        
        #region SearchObjects
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchObjects()
        {
            return SearchObjects(0,0);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchObjects(int maximumRows)
        {
            return SearchObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchObjects(int maximumRows, int startIndex)
        {
            return SearchObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.HSCodeDetails> oQuery =
                (from o in context.HSCodeDetails
                 where
                    (this.HSCode == null || this.HSCode == o.HSCode) &&
                    (this.ItemSubCategoryID == null || this.ItemSubCategoryID == o.ItemSubCategoryID) &&
                    (this.ItemSubCategory == null || this.ItemSubCategory == o.ItemSubCategory) &&
                    (this.GenderID == null || this.GenderID == o.GenderID) &&
                    (this.Gender == null || this.Gender == o.Gender) &&
                    (this.Code == null || this.Code == o.Code) 
                 orderby o.HSCode
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.HSCode).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.HSCodeDetailsBO> hscodedetailss = IQueryableToList(oQuery);
            context.Dispose();
            return hscodedetailss;
        }
        
        public int SearchObjectsCount()
        {
            IndicoEntities context = new IndicoEntities();
            return (from o in context.HSCodeDetails
                 where
                    (this.HSCode == null || this.HSCode == o.HSCode) &&
                    (this.ItemSubCategoryID == null || this.ItemSubCategoryID == o.ItemSubCategoryID) &&
                    (this.ItemSubCategory == null || this.ItemSubCategory == o.ItemSubCategory) &&
                    (this.GenderID == null || this.GenderID == o.GenderID) &&
                    (this.Gender == null || this.Gender == o.Gender) &&
                    (this.Code == null || this.Code == o.Code) 
                 orderby o.HSCode
                 select o).Count();
        }
        #endregion
        
        #region SearchObjectsLikeAnd
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchLikeAndObjects()
        {
            return SearchLikeAndObjects(0);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchLikeAndObjects(int maximumRows)
        {
            return SearchLikeAndObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchLikeAndObjects(int maximumRows, int startIndex)
        {
            return SearchLikeAndObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchLikeAndObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.HSCodeDetails> oQuery =
                (from o in context.HSCodeDetails
                 where
                    (this.HSCode == null || o.HSCode == this.HSCode) &&
                    (this.ItemSubCategoryID == null || o.ItemSubCategoryID == this.ItemSubCategoryID) &&
                    (this.ItemSubCategory == null || o.ItemSubCategory.Contains(this.ItemSubCategory)) &&
                    (this.GenderID == null || o.GenderID == this.GenderID) &&
                    (this.Gender == null || o.Gender.Contains(this.Gender)) &&
                    (this.Code == null || o.Code.Contains(this.Code)) 
                 orderby o.HSCode
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.HSCode).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.HSCodeDetailsBO> hscodedetailss = IQueryableToList(oQuery);
            context.Dispose();
            return hscodedetailss;
        }
        
        public int SearchLikeAndObjectsCount()
        {
            IndicoEntities context = new IndicoEntities();
            return (from o in context.HSCodeDetails
                 where
                    (this.HSCode == null || o.HSCode == this.HSCode) &&
                    (this.ItemSubCategoryID == null || o.ItemSubCategoryID == this.ItemSubCategoryID) &&
                    (this.ItemSubCategory == null || o.ItemSubCategory.Contains(this.ItemSubCategory)) &&
                    (this.GenderID == null || o.GenderID == this.GenderID) &&
                    (this.Gender == null || o.Gender.Contains(this.Gender)) &&
                    (this.Code == null || o.Code.Contains(this.Code)) 
                 orderby o.HSCode
                 select o).Count();
            
        }
        
        #endregion
        
        #region SearchObjectsLikeOr
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchLikeOrObjects()
        {
            return SearchLikeOrObjects(0);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchLikeOrObjects(int maximumRows)
        {
            return SearchLikeOrObjects(maximumRows, 0);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchLikeOrObjects(int maximumRows, int startIndex)
        {
            return SearchLikeOrObjects(maximumRows, startIndex, null, false);
        }
        public List<Indico.BusinessObjects.HSCodeDetailsBO> SearchLikeOrObjects(int maximumRows, int startIndex, string sortExpression, bool sortDescending)
        {
            IndicoEntities context = new IndicoEntities();
            IQueryable<Indico.DAL.HSCodeDetails> oQuery =
                (from o in context.HSCodeDetails
                 where
                    (this.HSCode == null || this.HSCode == o.HSCode) && 
                    (this.ItemSubCategoryID == null || this.ItemSubCategoryID == o.ItemSubCategoryID) && 
                    (this.GenderID == null || this.GenderID == o.GenderID) && 
                    ((o.ItemSubCategory.Contains(this.ItemSubCategory)) ||
                    (o.Gender.Contains(this.Gender)) ||
                    (o.Code.Contains(this.Code)) ||
                    (this.ItemSubCategory == null && this.Gender == null && this.Code == null ))
                 orderby o.HSCode
                 select o);

            if (sortExpression != null && sortExpression.Length > 0)
            {
                // using System.Linq.Dynamic here in Dynamic.cs;
                if (sortDescending)
                    oQuery = oQuery.OrderBy(sortExpression + " desc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
                else
                    oQuery = oQuery.OrderBy(sortExpression + " asc").Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);
            }
            else
                oQuery = oQuery.OrderBy(obj => obj.HSCode).Skip(startIndex).Take((maximumRows == 0) ? Int32.MaxValue : maximumRows);

            List<Indico.BusinessObjects.HSCodeDetailsBO> hscodedetailss = IQueryableToList(oQuery);
            context.Dispose();
            return hscodedetailss;
        }
        
        public int SearchLikeOrObjectsCount()
        {
            IndicoEntities context = new IndicoEntities();
            return (from o in context.HSCodeDetails
                 where
                    (this.HSCode == null || this.HSCode == o.HSCode) && 
                    (this.ItemSubCategoryID == null || this.ItemSubCategoryID == o.ItemSubCategoryID) && 
                    (this.GenderID == null || this.GenderID == o.GenderID) && 
                    ((o.ItemSubCategory.Contains(this.ItemSubCategory)) ||
                    (o.Gender.Contains(this.Gender)) ||
                    (o.Code.Contains(this.Code)) ||
                    (this.ItemSubCategory == null && this.Gender == null && this.Code == null ))
                 orderby o.HSCode
                 select o).Count();
            
        }
        #endregion
        
        #region Serialization methods
        /// <summary>
        /// Serializes the Indico.BusinessObjects.HSCodeDetailsBO to an XML representation
        /// </summary>
        /// <returns>a XML string serialized representation</returns>
        public string SerializeObject()
        {
            string strReturn = "";

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();

            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            x.Serialize(objStream, this);

            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            // Read string from binary file with UTF8 encoding
            strReturn = encoding.GetString(objStream.GetBuffer());

            objStream.Close();
            return strReturn;

        }

        /// <summary>
        /// Deserializes Indico.BusinessObjects.HSCodeDetailsBO object from an XML representation
        /// </summary>
        /// <param name="strXML">a XML string serialized representation</param>
        public Indico.BusinessObjects.HSCodeDetailsBO DeserializeObject(string strXML)
        {
            Indico.BusinessObjects.HSCodeDetailsBO objTemp = null;
            System.Xml.XmlDocument objXML = new System.Xml.XmlDocument();

            objXML.LoadXml(strXML);
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;

            System.IO.MemoryStream objStream = new System.IO.MemoryStream();
            byte[] b = encoding.GetBytes(objXML.OuterXml);

            objStream.Write(b, 0, (int)b.Length);
            objStream.Position = 0;
            System.Xml.Serialization.XmlSerializer x = new System.Xml.Serialization.XmlSerializer(this.GetType());

            objTemp = (Indico.BusinessObjects.HSCodeDetailsBO)x.Deserialize(objStream);
            objStream.Close();
            return objTemp;
        }

        /// <summary>
        /// Returns a simple XML representation of Indico.BusinessObjects.HSCodeDetailsBO object in an XmlElement
        /// </summary>
        /// <returns>An XML snippet representing the object</returns>
        public string ToXmlString()
        {
            // MW TODO - implement this better.
            return SerializeObject();
        }
        #endregion
        
        #region IComparable Members

        public int CompareTo(object obj)
        {
            if (!(obj is Indico.BusinessObjects.HSCodeDetailsBO))
                return 1;
            Indico.BusinessObjects.HSCodeDetailsBOComparer c = new Indico.BusinessObjects.HSCodeDetailsBOComparer();
            return c.Compare(this, obj as Indico.BusinessObjects.HSCodeDetailsBO);
        }

        #endregion
        #endregion
    }
    
    #region HSCodeDetailsBOComparer
    public class HSCodeDetailsBOComparer : IComparer<Indico.BusinessObjects.HSCodeDetailsBO>
    {
        private string propertyToCompareName;
        public HSCodeDetailsBOComparer(string propertyToCompare)
        {
            PropertyInfo p = typeof(Indico.BusinessObjects.HSCodeDetailsBO).GetProperty(propertyToCompare);
            if (p == null)
                throw new ArgumentException("is not a public property of Indico.BusinessObjects.HSCodeDetailsBO", "propertyToCompare");
            this.propertyToCompareName = propertyToCompare;
        }
        
        public HSCodeDetailsBOComparer()
        {
        
        }

        #region IComparer<Indico.BusinessObjects.HSCodeDetailsBO> Members
        public int Compare(Indico.BusinessObjects.HSCodeDetailsBO x, Indico.BusinessObjects.HSCodeDetailsBO y)
        {
            if (propertyToCompareName != null)
            {
                PropertyInfo p = typeof(Indico.BusinessObjects.HSCodeDetailsBO).GetProperty(propertyToCompareName);
                return compare(p, x, y);
            }
            else
            {
                PropertyInfo[] arrP = typeof(Indico.BusinessObjects.HSCodeDetailsBO).GetProperties();
                foreach (PropertyInfo p in arrP)
                {
                    int v = compare(p, x, y);
                    if (v != 0)
                        return v;
                }
                return 0;
            }
        }

        private int compare(PropertyInfo p, Indico.BusinessObjects.HSCodeDetailsBO x, Indico.BusinessObjects.HSCodeDetailsBO y)
        {
            object xVal = p.GetValue(x, null);
            object yVal = p.GetValue(y, null);

            if (xVal == null)
            {
                if (yVal == null)
                    return 0;
                else
                    return -1; // x is null, y is not, y is greater
            }
            else
            {
                if (y == null)
                    return 1; // x non null, y is null, x is greater
                else if (xVal is string)
                {
                    return StringComparer.OrdinalIgnoreCase.Compare(xVal, yVal);
                }
                else if (xVal is IComparable)
                {
                    return ((IComparable)xVal).CompareTo((IComparable)yVal);
                }
                else
                    throw new ArgumentException
                        ("is not string or valuetype that implements IComparable", "propertyToCompare");

            }
        }

        #endregion
    }
    #endregion
}
